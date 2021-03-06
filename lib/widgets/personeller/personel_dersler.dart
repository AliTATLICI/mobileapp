// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Pazartesi',
    <Entry>[
      Entry(
        'Ders 1',
        <Entry>[
          Entry('Saat 1'),
          Entry('Saat 2'),
          Entry('Saat 3'),
        ],
      ),
      Entry('Ders 2'),
      Entry('Ders 3'),
    ],
  ),
  Entry(
    'Salı',
    <Entry>[
      Entry('Ders 1'),
      Entry('Ders 2'),
    ],
  ),
  Entry(
    'Çarşamba',
    <Entry>[
      Entry('Ders 1'),
      Entry('Ders 2'),
      Entry(
        'Ders 3',
        <Entry>[
          Entry('Saat 1'),
          Entry('Saat 2'),
          Entry('Saat 3'),
          Entry('Saat 4'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title), );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
