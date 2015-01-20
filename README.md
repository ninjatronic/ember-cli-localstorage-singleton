# ember-cli-localstorage-singleton

> Persistent singletons in HTML5 localStorage for Ember CLI apps

## Installation

```
ember install:addon localstorage-singleton
```

## Usage

Use this extension to create persistent singletons for your Ember CLI apps.

```coffeescript
`import Ember from 'ember'`
`import LocalStorageSingleton from 'localstorage-singleton/lib/localstorage-singleton'`


Settings = LocalStorageSingleton.extend Ember.Evented

  # optional
  becameError: ->
    @trigger 'becameError'

  # optional 
  didSave: ->
    @trigger 'didSave'


Settings.reopenClass
  key: 'settings' # the key to persist the singleton under in localStorage


`export default Settings`
```

### General Usage

**app/routes/myRoute**

```coffeescript
`import Ember from 'ember'`
`import Settings from 'app/singletons/settings'`


MyRoute = Ember.Route.extend

  model: ->
    Settings.create
      lastAccess: new Date().toString()


`export default MyController`
```

### Usage in an Initializer

**app/initializers/settings**

```coffeescript
`import Ember from 'ember'`
`import Settings from 'app/singletons/settings'`


initializer =
  name: 'settings'
  initialize: (container, application) ->
    container.register 'settings:main', Settings, singleton: true
    application.inject 'controller', 'settings', 'settings:main'
    application.inject 'route', 'settings', 'settings:main'


`export default initializer`
```

**app/controllers/my-controller**

```coffeescript
`import Ember from 'ember'`


MyController = Ember.Controller.extend

  lastAccess: Ember.computed.alias 'settings.lastAccess'

  actions:
    doSomething: ->
      @set 'settings.lastAccess', new Date().toString()


`export default MyController`
```
