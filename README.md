# ember-cli-localstorage-singleton

> Store singletons in localstorage in Ember CLI apps

## Installation

```
ember install:addon localstorage-singleton
```

## Usage

Use this extension to create persistent singletons for your Ember CLI apps.

```
###

`import LocalStorageSingleton from 'localstorage-singleton/lib/localstorage-singleton'`

Settings = LocalStorageSingleton.extend()
Settings.reopenClass
  key: 'settings' # the key to persist the singleton under in localStorage

initializer =
  name: 'settings'
  initialize: (container, application) ->
    container.register 'settings:main', Settings, singleton: true
    application.inject 'controller', 'settings', 'settings:main'
    application.inject 'route', 'settings', 'settings:main'

`export default initializer`
```
