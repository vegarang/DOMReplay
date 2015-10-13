####################
# Initialization
####################
express = require "express"
mongoose = require "mongoose"
Schema = mongoose.Schema
bodyParser = require "body-parser"

app = express()
app.use bodyParser.json()

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
  Blob.findOneAndUpdate values, 'user_id _id data', (err, blob) ->
    if err
      return handleError err, res
    returnBlob "updated", res, blob


################
# Http functions
################
app.get '/', (req, res) ->
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


app.post '/', (req, res) ->
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
