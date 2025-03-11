import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/language/language.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  DocType selectedDocType = DocType.user_agreement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100.0,
        leading: StyledBackButton(
          onTap: () {
            context.pop();
          },
        ),
        actions: const [
          LanguageChooseButton(),
          HSpacer(AppDimensions.paddingMedium),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 80.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: DocTypeButtonSelector(
                            onChanged: (value) {
                              setState(() {
                                selectedDocType = value;
                              });
                            },
                            value: DocType.user_agreement,
                            groupValue: selectedDocType,
                            title: context.loc.user_agreement,
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        Expanded(
                          child: DocTypeButtonSelector(
                            onChanged: (value) {
                              setState(() {
                                selectedDocType = value;
                              });
                            },
                            value: DocType.privacy,
                            groupValue: selectedDocType,
                            title: context.loc.privacy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingMedium,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DocTypeButtonSelector(
                            onChanged: (value) {
                              setState(() {
                                selectedDocType = value;
                              });
                            },
                            value: DocType.master_contract,
                            groupValue: selectedDocType,
                            title: context.loc.master_contract,
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        const Spacer(),
                      ],
                    )),
                const VSpacer(AppDimensions.paddingMedium),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: StyledBackgroundContainer(
              child: FutureBuilder(
                  future: _getMdFile(selectedDocType),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Ошибка: ${snapshot.error}');
                    } else {
                      return MarkdownBody(data: snapshot.data!);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getMdFile(DocType doc) async {
    return await rootBundle
        .loadString('assets/docs/${context.loc.localeName}/${doc.name}.md');
  }
}

class DocTypeButtonSelector extends StatelessWidget {
  final DocType value;
  final DocType groupValue;
  final ValueChanged<DocType> onChanged;
  final String title;

  const DocTypeButtonSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    return ElevatedButton(
      onPressed: () {
        if (isSelected) {
          return;
        }
        onChanged(value);
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}

enum DocType {
  privacy,
  master_contract,
  user_agreement,
}
