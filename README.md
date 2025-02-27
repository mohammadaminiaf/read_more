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

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  readmore: ^1.0.0
```

## Usage

```dart
import 'package:readmore/readmore.dart';

ReadMoreText(
  'Your long text here...',
  trimLines: 2,
  trimMode: TrimMode.line,
  readMoreText: 'Show more',
  readLessText: 'Show less',
  moreStyle: TextStyle(color: Colors.blue),
  lessStyle: TextStyle(color: Colors.blue),
)
```

## Parameters

| Parameter          | Description                          | Default       |
|--------------------|--------------------------------------|---------------|
| `text`             | The text to display (required)       | -             |
| `trimLines`        | Number of lines to show when trimmed | 2             |
| `trimMode`         | Truncate by line or length           | TrimMode.line |
| `readMoreText`     | "Read More" button text              | 'Read More'   |
| `readLessText`     | "Show Less" button text              | 'Show Less'   |
| `moreStyle`        | Style for "Read More" text           | Blue bold     |
| `lessStyle`        | Style for "Show Less" text           | Blue bold     |

## Screenshots

![Demo](https://github.com/yourusername/readmore/raw/main/demo.gif)