`import Ember from 'ember'`


LocalStorageSingleton = Ember.Object.extend

  # the key to use in localStorage - statically defined on type
  _storageKey: Ember.computed ->
    @constructor.key


  #
  # SERIALIZATION
  #

  _serialize: (deserialized) ->
    JSON.stringify deserialized

  _deserialize: (serialized) ->
    if serialized? then JSON.parse serialized else null


  #
  # MECHANISM
  #
  # the core functionality of localstorage-singleton: a singleton object is a
  # proxy for a JSON structure in a HTML5 localStorage key
  #

  unknownProperty: (key) ->
    storageKey = @get '_storageKey'

    instance = @_deserialize localStorage.getItem storageKey
    instance ?= {}

    return instance[key]

  setUnknownProperty: (key, value) ->
    @propertyWillChange key

    storageKey = @get '_storageKey'

    instance = @_deserialize localStorage.getItem storageKey
    instance ?= {}

    instance[key] = value

    @set 'isSaving', true
    try
      localStorage.setItem storageKey, @_serialize instance
      @set 'isError', false
      @didSave?()
    catch
      @set 'isError', true
      @becameError?()
    finally
      @set 'isSaving', false
      @propertyDidChange key


  #
  # PUBLIC API
  #

  # true iff the object is currently saving
  isSaving: false

  # true iff the last attempt to save the object caused an error
  isError: false


`export default LocalStorageSingleton`
