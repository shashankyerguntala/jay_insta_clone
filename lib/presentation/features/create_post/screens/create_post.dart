import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_bloc.dart';
import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_event.dart';
import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_state.dart';
import 'package:jay_insta_clone/presentation/features/create_post/widgets/custom_input_decoration.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePostBloc(postUseCase: di()),
      child: Scaffold(
        backgroundColor: ColorConstants.fillColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.fillColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Create Post",
            style: TextStyle(
              color: ColorConstants.textPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocConsumer<CreatePostBloc, CreatePostState>(
              listener: (context, state) {
                if (state is CreatePostSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Post Created Successfully!"),
                      backgroundColor: ColorConstants.successColor,
                    ),
                  );
                  titleController.clear();
                  descriptionController.clear();
                } else if (state is CreatePostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is CreatePostLoading;

                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLength: 50,
                        controller: titleController,
                        decoration: CustomInputDecoration.inputDecoration(
                          "Title",
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter a title"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLength: 1000,
                        controller: descriptionController,
                        maxLines: 6,
                        decoration: CustomInputDecoration.inputDecoration(
                          "Description",
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter a description"
                            : null,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 3,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => {
                                  if (formKey.currentState!.validate())
                                    {
                                      context.read<CreatePostBloc>().add(
                                        SubmitPostEvent(
                                          title: titleController.text,
                                          content: descriptionController.text,
                                        ),
                                      ),
                                    },
                                },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Post",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
