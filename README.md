# measurer

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

