import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/string_constants.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_bloc.dart';
import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_event.dart';
import 'package:jay_insta_clone/presentation/features/create_post/bloc/create_post_state.dart';
import 'package:jay_insta_clone/presentation/features/create_post/widgets/custom_input_decoration.dart';
import 'package:jay_insta_clone/core%20/di/di.dart';

class CreatePost extends StatefulWidget {
  final bool isEdit;
  final PostEntity? post;
  const CreatePost({super.key, this.post, required this.isEdit});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      titleController.text = widget.post!.title;
      descriptionController.text = widget.post!.content;
    }
  }

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
          title: widget.isEdit
              ? Text(
                  StringConstants.editPost,
                  style: TextStyle(
                    color: ColorConstants.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              : Text(
                  StringConstants.createPost,
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
                    SnackBar(
                      content: widget.isEdit
                          ? Text(StringConstants.postEdited)
                          : Text(StringConstants.postCreated),
                      backgroundColor: ColorConstants.successColor,
                    ),
                  );
                  titleController.clear();
                  descriptionController.clear();
                } else if (state is CreatePostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: widget.isEdit
                          ? Text(StringConstants.errorWhileEditing)
                          : Text(state.error),
                      backgroundColor: ColorConstants.errorColor,
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
                          StringConstants.title,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? StringConstants.enterTitle
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLength: 1000,
                        controller: descriptionController,
                        maxLines: null,
                        decoration: CustomInputDecoration.inputDecoration(
                          StringConstants.desc,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? StringConstants.enterDesc
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
                                      if (widget.isEdit)
                                        {
                                          context.read<CreatePostBloc>().add(
                                            EditPostEvent(
                                              title: titleController.text
                                                  .trim(),
                                              content: descriptionController
                                                  .text
                                                  .trim(),
                                              postId: widget.post!.id,
                                            ),
                                          ),
                                        }
                                      else
                                        {
                                          context.read<CreatePostBloc>().add(
                                            SubmitPostEvent(
                                              title: titleController.text,
                                              content:
                                                  descriptionController.text,
                                            ),
                                          ),
                                        },
                                    },
                                },
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: ColorConstants.fillColor,
                                )
                              : widget.isEdit
                              ? const Text(
                                  StringConstants.edit,
                                  style: TextStyle(
                                    color: ColorConstants.fillColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const Text(
                                  StringConstants.post,
                                  style: TextStyle(
                                    color: ColorConstants.fillColor,
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
