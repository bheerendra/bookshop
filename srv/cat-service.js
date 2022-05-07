const cds = require('@sap/cds')

class CatalogService extends cds.ApplicationService { init(){

  const { Books } = cds.entities ('com.sap.bookshop')

  // Reduce stock of ordered books if available stock suffices
  this.on ('submitOrder', async req => {
    const {book,quantity} = req.data
    if (quantity < 1) return req.reject (400,`quantity has to be 1 or more`)
    let b = await SELECT `stock` .from (Books,book)
    if (!b) return req.error (404,`Book #${book} doesn't exist`)
    let {stock} = b
    if (quantity > stock) return req.reject (409,`${quantity} exceeds stock for book #${book}`)
    await UPDATE (Books,book) .with ({ stock: stock -= quantity })
    await this.emit ('OrderedBook', { book, quantity, buyer:req.user.id })
    return { stock }
  })

  this.on('getAuthors', async (req) => {
    try {
        const tx = cds.transaction(req)
        var inID = req.data && req.data.ID || null;
        var vProcedure = 'call P_AUTHORS('+ inID +',OUT_AUTHOR => ?)'
        var output = await tx.run (vProcedure);            
        return output.OUT_AUTHOR;
    } catch (error) {
        console.error(error)
        return false
    }
    })

    this.on('READ', 'Authors', async (req) => {
        try {
            
            const tx = cds.transaction(req)
            var inID = req.data && req.data.ID || null;
            var vProcedure = 'call P_AUTHORS('+ inID +',OUT_AUTHOR => ?)'
            var output = await tx.run (vProcedure);            
            return output.OUT_AUTHOR;
        } catch (error) {
            console.error(error)
            return false
        }
        })
    

  // Add some discount for overstocked books
  this.after ('READ','ListOfBooks', each => {
    if (each.stock > 111) each.title += ` -- 11% discount!`
  })

  this.on('sleep', async () => {
    try {
        const dbClass = require("sap-hdb-promisfied")
        let dbConn = new dbClass(await dbClass.createConnectionFromEnv())
        const sp = await dbConn.loadProcedurePromisified(null, '"sleep"')
        const output = await dbConn.callProcedurePromisified(sp, [])
        console.log(output.results)
        return true
    } catch (error) {
        console.error(error)
        return false
    }
    })



  return super.init()
}}

module.exports = { CatalogService }
