import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/course_entity.dart';
import '../../blocs/course/course_bloc.dart';

class EditCoursePage extends StatefulWidget {
  final CourseEntity course;

  const EditCoursePage({super.key, required this.course});

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _tagsController;
  late final TextEditingController _youtubeUrlController;
  late final TextEditingController _pdfUrlController;
  String? _imagePath;
  bool _imageChanged = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.course.title);
    _descriptionController = TextEditingController(
      text: widget.course.description,
    );
    _priceController = TextEditingController(
      text: widget.course.price.toString(),
    );
    _tagsController = TextEditingController(
      text: widget.course.tags.join(', '),
    );
    _youtubeUrlController = TextEditingController(
      text: widget.course.youtubeUrl ?? '',
    );
    _pdfUrlController = TextEditingController(text: widget.course.pdfUrl ?? '');
    _imagePath = widget.course.imageUrl;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _tagsController.dispose();
    _youtubeUrlController.dispose();
    _pdfUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
        _imageChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Course')),
      body: BlocConsumer<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Course updated successfully!')),
            );
            Navigator.pop(context);
          } else if (state is CourseError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _imageChanged
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 8),
                                Text('New image selected'),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.edit, size: 50),
                                const SizedBox(height: 8),
                                Text(
                                  _imagePath != null
                                      ? 'Tap to change image'
                                      : 'Tap to add image',
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Course Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (\$)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      if (double.tryParse(value!) == null) {
                        return 'Invalid price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      labelText: 'Tags (comma separated)',
                      border: OutlineInputBorder(),
                      hintText: 'e.g., Flutter, Mobile, Programming',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _youtubeUrlController,
                    decoration: const InputDecoration(
                      labelText: 'YouTube URL (Optional)',
                      border: OutlineInputBorder(),
                      hintText: 'https://www.youtube.com/watch?v=...',
                      prefixIcon: Icon(Icons.video_library),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pdfUrlController,
                    decoration: const InputDecoration(
                      labelText: 'PDF URL (Optional)',
                      border: OutlineInputBorder(),
                      hintText: 'https://example.com/document.pdf',
                      prefixIcon: Icon(Icons.picture_as_pdf),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final tags = _tagsController.text
                              .split(',')
                              .map((e) => e.trim())
                              .where((e) => e.isNotEmpty)
                              .toList();

                          final youtubeUrl = _youtubeUrlController.text.trim();
                          final pdfUrl = _pdfUrlController.text.trim();

                          context.read<CourseBloc>().add(
                            UpdateCourseEvent(
                              courseId: widget.course.id,
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              price: double.parse(_priceController.text),
                              tags: tags,
                              imagePath: _imageChanged ? _imagePath : null,
                              youtubeUrl: youtubeUrl.isEmpty
                                  ? null
                                  : youtubeUrl,
                              pdfUrl: pdfUrl.isEmpty ? null : pdfUrl,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Update Course',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
