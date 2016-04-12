path= require 'path'
mkdirp= require 'mkdirp'
koa= require('koa')
koaBody= require('koa-body')
route= require('koa-route')

app= module.exports= koa()

app.use koaBody({
    multipart: true,
    formidable:
        uploadDir: __dirname+ '/temp'
        onFileBegin: (name, file)->
            folder= path.dirname(file.path)
            file.path= path.join(folder, file.name)
            mkdirp.sync path.dirname(file.path)
})

app.use route.post '/', ->
    if @request.method is 'POST'
        # => POST body
        @body= @request.body

        yield return


unless module.parent then app.listen 3131
