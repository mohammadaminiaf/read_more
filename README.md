# ReadMore Flutter Package

[![pub package](https://img.shields.io/pub/v/readmore.svg)](https://pub.dev/packages/readmore)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter widget that truncates text with customizable "Read More" and "Show Less" functionality.

## Features

- Truncate text by line or character length
- Customizable "Read More" and "Show Less" text
- Style customization for both text and buttons
- Callbacks for expand/collapse events
- Supports RTL and LTR text directions
- Blurred overlay for hidden text

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  readmore: ^1.0.0
```

## Usage

### BlurredReadMore Example

```dart
import 'package:readmore_flutter/src/blurred_readmore.dart';

BlurredReadMore(
  'Your long text here...',
  style: TextStyle(fontSize: 16, color: Colors.black),
  minLines: 3,
  extraBlurLines: 2,
  blurHeight: 20.0,
  blurColor: Colors.white,
  iconSize: 30.0,
  collapsedIcon: Icons.keyboard_arrow_down,
  expandedIcon: Icons.keyboard_arrow_up,
)
```

### ReadMore Example

```dart
import 'package:readmore_flutter/src/readmore.dart';

ReadMore(
  'Your long text here...',
  style: TextStyle(fontSize: 16, color: Colors.black),
  minLines: 3,
  readMoreText: 'Read more',
  readLessText: 'Read less',
  readMoreStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  readMoreIconVisible: true,
  readMoreIcon: Icons.keyboard_arrow_down,
  readLessIcon: Icons.keyboard_arrow_up,
  iconSize: 20,
  alignCenter: false,
)
```

## Parameters

### BlurredReadMore

| Parameter        | Description                          | Default                     |
|------------------|--------------------------------------|-----------------------------|
| `text`           | The text to display (required)       | -                           |
| `minLines`       | Number of lines to show when trimmed | 3                           |
| `extraBlurLines` | Additional lines to blur             | 2                           |
| `blurHeight`     | Height of the blur effect            | 20.0                        |
| `blurColor`      | Color of the blur effect             | Colors.white                |
| `style`          | Style for the text                   | Default TextStyle           |
| `iconSize`       | Size of the expand/collapse icon     | 30.0                        |
| `collapsedIcon`  | Icon when text is collapsed          | Icons.keyboard_arrow_down   |
| `expandedIcon`   | Icon when text is expanded           | Icons.keyboard_arrow_up     |

### ReadMore

| Parameter          | Description                          | Default                     |
|--------------------|--------------------------------------|-----------------------------|
| `text`             | The text to display (required)       | -                           |
| `minLines`         | Number of lines to show when trimmed | 3                           |
| `readMoreText`     | "Read More" button text              | 'Read more'                 |
| `readLessText`     | "Show Less" button text              | 'Read less'                 |
| `readMoreStyle`    | Style for "Read More" text           | Primary color, bold         |
| `style`            | Style for the text                   | Default TextStyle           |
| `readMoreIconVisible` | Show icon next to text            | true                        |
| `readMoreIcon`     | Icon when text is collapsed          | Icons.keyboard_arrow_down   |
| `readLessIcon`     | Icon when text is expanded           | Icons.keyboard_arrow_up     |
| `iconSize`         | Size of the expand/collapse icon     | 20                          |
| `alignCenter`      | Center align the text and button     | false                       |
| `trimExpandedText` | Text to show when expanded           | ''                          |
| `trimCollapsedText`| Text to show when collapsed          | ''                          |
| `callback`         | Callback for expand/collapse events  | null                        |

## Screenshots

![Demo](https://github.com/yourusername/readmore/raw/main/demo.gif)