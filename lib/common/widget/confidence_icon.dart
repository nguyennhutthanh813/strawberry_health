import 'package:flutter/material.dart';

String getEmoji(double confidence) {
  if (confidence < 0.25) return '🔴';
  if (confidence < 0.5) return '🟠';
  if (confidence < 0.75) return '🟡';
  return '🟢';
}

