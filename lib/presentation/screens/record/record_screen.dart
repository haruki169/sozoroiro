import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/services/color_extraction_service.dart';
import '../../../data/services/location_service.dart';
import '../../providers/entry_providers.dart';
import '../../providers/theme_providers.dart';
import '../../widgets/color_swatch.dart';

class RecordScreen extends ConsumerStatefulWidget {
  const RecordScreen({super.key, required this.dailyThemeId});

  final int dailyThemeId;

  @override
  ConsumerState<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen> {
  final _colorExtractionService = ColorExtractionService();
  final _locationService = LocationService();
  final _memoController = TextEditingController();

  File? _photo;
  String? _extractedColorHex;
  bool _extractionFailed = false;
  bool _locationToggle = false; // デフォルトOFF（要件8章）
  bool _isSaving = false;
  String? _saveError;

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    final picker = ImagePicker();
    final XFile? picked;
    try {
      picked = await picker.pickImage(source: ImageSource.camera);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('カメラを利用できませんでした。')),
      );
      return;
    }
    if (picked == null) return;

    final file = File(picked.path);
    final colorHex = await _colorExtractionService.extractDominantColorHex(
      file,
    );

    setState(() {
      _photo = file;
      _extractedColorHex = colorHex;
      _extractionFailed = colorHex == null;
    });
  }

  Future<void> _save() async {
    if (_photo == null) return;

    setState(() {
      _isSaving = true;
      _saveError = null;
    });

    try {
      double? lat;
      double? lng;
      if (_locationToggle) {
        final position = await _locationService.getCurrentPositionIfEnabled(
          true,
        );
        lat = position?.latitude;
        lng = position?.longitude;
      }

      await ref
          .read(entryRepositoryProvider)
          .createEntry(
            photo: _photo!,
            extractedColorHex: _extractedColorHex ?? '#9E9E9E',
            dailyThemeId: widget.dailyThemeId,
            memo: _memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim(),
            lat: lat,
            lng: lng,
            locationRecorded: _locationToggle,
          );

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      setState(() {
        _saveError = '保存できませんでした。少し時間をおいてもう一度お試しください。';
      });
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(dailyThemeByIdProvider(widget.dailyThemeId));

    return Scaffold(
      appBar: AppBar(title: const Text('色を記録する')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              themeAsync.when(
                data: (theme) => theme == null
                    ? const SizedBox.shrink()
                    : IgnorePointer(
                        child: Opacity(
                          opacity: 0.5,
                          child: Chip(label: Text(theme.catalog.name)),
                        ),
                      ),
                loading: () => const SizedBox.shrink(),
                error: (e, s) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: GestureDetector(
                  onTap: _capture,
                  child: _photo == null
                      ? Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(
                              AppRadii.card,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadii.card),
                          child: Image.file(
                            _photo!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (_photo != null)
                Center(
                  child: Column(
                    children: [
                      ColorDot(colorHex: _extractedColorHex, size: 56),
                      if (_extractionFailed) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '色をうまく読み取れませんでした。このまま保存できます。',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _memoController,
                decoration: const InputDecoration(
                  labelText: '一言メモ（任意）',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.md),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('位置情報を記録する'),
                subtitle: const Text('オフのままでも記録できます'),
                value: _locationToggle,
                onChanged: (value) => setState(() => _locationToggle = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_saveError != null) ...[
                Text(
                  _saveError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              FilledButton(
                onPressed: _photo == null || _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('この色を日記に加える'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
