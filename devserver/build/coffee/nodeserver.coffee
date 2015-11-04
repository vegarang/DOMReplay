####################
# Initialization
####################
express = require "express"
mongoose = require "mongoose"
Schema = mongoose.Schema
bodyParser = require "body-parser"

app = express()
app.use bodyParser.json()

tmp = __dirname.split "/"
tmp.pop()
tmp.pop()
public_dir = "#{tmp.join '/'}/public"
tmp.pop()
project_dir = "#{tmp.join '/'}/build"
bower_dir = "#{tmp.join '/'}/bower_components"
src_dir = "#{tmp.join '/'}/src/js"

app.use '/public', express.static public_dir
app.use '/project', express.static project_dir
app.use '/bower', express.static bower_dir
app.use '/src', express.static src_dir


PORT = 3000


####################
# DB setup
####################

connection = mongoose.connect('mongodb://localhost:27017/domreplay');

blobSchema = new Schema
  user_id: Number
  data: [
    {
      event_type: String
      id: String
      value: String
    }
  ]

Blob = mongoose.model 'blobmodel', blobSchema, 'blobmodel'


####################
# DB util functions
####################

handleError = (err, res) ->
  if err
    res.json
      status: "error"
      msg: err

returnBlob = (status, res, blob) ->
  res.json
    status: status
    session_id: blob._id
    user_id: blob.user_id
    data: blob.data

createBlob = (res, values) ->
  blob = new Blob values
  blob.save (err, blob) ->
    if err
      return handleError(err, res)
    returnBlob "created", res, blob

updateBlob = (res, values) ->
  query =
    _id: values._id
  update =
    data: values.data
    user_id: values.user_id

  Blob.findOneAndUpdate query, update, {new: true}, (err, blob) ->
    if err
      return handleError err, res
    returnBlob "updated", res, blob


################
# Http functions
################
app.get '/api', (req, res) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Headers", "X-Requested-With"

  if not req.query.session_id
    res.json
      status: "error"
      msg: "cannot fetch blob without session_id"

  blob_values =
    _id: req.query.session_id

  if req.query.user_id
    blob_values['user_id'] = req.query.user_id

  Blob.findOne blob_values, (err, blob) ->
    if err
      return handleError err, res

    returnBlob "success", res, blob


app.post '/api', (req, res) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Headers", "X-Requested-With"

  blob_values =
    data: req.body.data

  if req.body.user_id
    blob_values['user_id'] = req.body.user_id

  if not req.body.session_id
    #creating new
    createBlob res, blob_values
  else
    #updating existing
    blob_values['_id'] = req.body.session_id
    updateBlob res, blob_values


server = app.listen PORT, () ->
  console.log "server running on port #{PORT}"
  return
