# measurer

<p>
  <a href="https://pub.dartlang.org/packages/measurer"><img src="https://img.shields.io/pub/v/measurer.svg"></a>
  <a href="https://www.buymeacoffee.com/aloisdeniel">
    <img src="https://img.shields.io/badge/$-donate-ff69b4.svg?maxAge=2592000&amp;style=flat">
  </a>
</p>

A widget that measure the size of its child.

## Quickstart

```dart
@override
Widget build(BuildContext context) {
    return Measurer(
        onMeasure: (size,constraints) {
            print('Child new size: $size');
        },
        child: Child(),
    );
}
```

## Usage

### onMeasure

A callback to that is called each time the layout size of the child changes.

### onPaintBoundsChanged

A callback to that is called each time the painting bound size (an absolute rectangle that contains all the pixels painted by the child)  of the child changes.

