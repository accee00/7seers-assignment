import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> seedGuides(FirebaseFirestore firestore) async {
  final collection = firestore.collection('guides');
  final batch = firestore.batch();

  final dummyGuides = [
    {
      'title': 'The first sleepless month',
      'subtitle': 'A short read on what no one tells you.',
      'content':
          'The first month is all about survival. Sleep when the baby sleeps, and don\'t worry about a messy house...',
      'imageUrl': 'https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=800',
      'readtime': 6,
    },
    {
      'title': 'How to be there when you don\'t know how',
      'subtitle': 'Supporting your partner through postpartum.',
      'content':
          'Sometimes the best support is just listening without trying to fix everything. Bring water, snacks, and patience...',
      'imageUrl': 'https://images.unsplash.com/photo-1492725764893-90b379c2b6e7?w=800',
      'readtime': 8,
    },
    {
      'title': 'First-time dads talking it out',
      'subtitle': 'A roundtable on the unexpected challenges.',
      'content':
          'We gathered five dads to talk about their transition to fatherhood. The main consensus? Everyone is winging it...',
      'imageUrl': 'https://images.unsplash.com/photo-1531983412531-1f49a365ffed?w=800',
      'readtime': 12,
    },
    {
      'title': 'Navigating sleep regressions',
      'subtitle': 'Why your good sleeper suddenly isn\'t.',
      'content':
          'Right around 4 months, their sleep cycles change completely. Here is what to expect and how to handle it...',
      'imageUrl': 'https://images.unsplash.com/photo-1544126592-807ade215a0b?w=800',
      'readtime': 5,
    },
    {
      'title': 'The art of the 5-minute break',
      'subtitle': 'Recharging in small increments.',
      'content':
          'You might not get an hour to yourself, but 5 minutes of mindful breathing can reset your nervous system...',
      'imageUrl': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
      'readtime': 4,
    },
  ];

  DateTime baseTime = DateTime.now().subtract(const Duration(days: 10));

  for (int i = 0; i < dummyGuides.length; i++) {
    final docRef = collection.doc();
    final guide = dummyGuides[i];

    final createdAt = baseTime.add(Duration(days: i));

    batch.set(docRef, {
      ...guide,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(createdAt),
    });
  }

  try {
    await batch.commit();
    if (kDebugMode) {
      print('✅ Successfully seeded ${dummyGuides.length} guides to Firestore!');
    }
  } catch (e) {
    if (kDebugMode) {
      print('❌ Error seeding guides: $e');
    }
  }
}
