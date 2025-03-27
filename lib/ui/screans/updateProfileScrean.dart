import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/tm_app_bar.dart';

class UpdateProfileScrean extends StatefulWidget {
  const UpdateProfileScrean({super.key});

  @override
  State<UpdateProfileScrean> createState() => _UpdateProfileScreanState();
}

class _UpdateProfileScreanState extends State<UpdateProfileScrean> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreanBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: getImage,
                  child: _BuildPhotoPicketWidget(),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onTapSubmitButton,
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapPhotoSubmitButton() {
    ImageSource.camera;
  }

  onTapSubmitButton() {}
  onTapPhotoPicker() {
    ImageSource.camera;
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}

class _BuildPhotoPicketWidget extends StatelessWidget {
  const _BuildPhotoPicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 100,
          child: Center(
            child: Text('Photos', style: TextStyle(color: Colors.white)),
          ),

          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
          ),
        ),
        SizedBox(width: 5),
        Text(
          'Select your Photo',
          style: TextTheme.of(
            context,
          ).titleMedium!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }
}
