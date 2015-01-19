`import Ember from 'ember'`
`import LocalStorageError from 'localstorage-singleton/lib//localstorage-error'`

LocalStorageSingleton = Ember.Object.extend

  _key: Ember.computed ->
    @constructor.key

  _serialize: (target) ->

  _persist: ->
    localStorage.setItem @get('_key'), @_serialize this

  create: (arguments) ->
    @_super arguments
    @_persist()

  unknownProperty: (key) ->
    instance = JSON.parse localStorage.getItem @get '_key'
    return instance[key]

  setUnknownProperty: (key, value) ->
    instance = JSON.parse localStorage.getItem @get '_key'
    instance[key] = value

    try
      localStorage.setItem @get '_key', instance
    catch e
      throw new LocalStorageError e


`export default LocalStorageSingleton`
