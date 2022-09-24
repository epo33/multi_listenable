# multi_listenable

A widget whose content stays synced with a list of Listenable.

## Usage

* Add the as a dependency in your project with `flutter pub add multi_listenable`

* Import `package:multi_listenable/multi_listenable.dart` in required files.

* Use `MultiValueListenableBuilder` in your widget tree :

```
MultiListenableBuilder( 
	listenable: [ /* your listables to listen */],
	builder : (context) => Container(),
)
```

## Parameters

### Iterable[Listenable] listenable
An iterable of [Listenable] to listen. When one of the listenable notify,
the builder function is called.

### [WidgetBuilder] builder 
A function to call every time a [Listener] passed in [listenable] notify.

An exemple can be found [here](https://github.com/epo33/multi_listenable/tree/trunk/example/)