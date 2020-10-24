import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/presentation/presentation_step.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:allthenews/src/ui/pages/presentation/indicator_container.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_steps_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const headerVerticalPadding = 24.0;
  static const indicatorAnimationDuration = Duration(milliseconds: 300);
  static const nextButtonHeight = 100.0;
  static const nextButtonPadding = 24.0;
  static const presentationStepVerticalSpacing = 20.0;
}

class PresentationPage extends StatefulWidget {
  @override
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final _controller = PageController();
  final _presentationStepsProvider = PresentationStepsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildPresentationHeader(context),
            _buildPresentationContent(),
            _buildPresentationFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPresentationFooter(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(
        height: _Constants.nextButtonHeight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(_Constants.nextButtonPadding),
        child: PrimaryTextButton(
          text: Strings.of(context).next,
          onPressed: () {
            if (_controller.page.toInt() == _presentationStepsProvider.provide().length - 1) {
              _navigateToHomePage(context);
            } else {
              _goNextPage();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPresentationHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _Constants.headerVerticalPadding),
      child: Row(
        children: [
          const Spacer(flex: 2),
          IndicatorContainer(
            controller: _controller,
            itemCount: _presentationStepsProvider.provide().length,
            onPageSelected: (int page) => _goToPage(page),
          ),
          const Spacer(),
          FlatButton(
            onPressed: () => _navigateToHomePage(context),
            child: Text(Strings.of(context).skip),
          )
        ],
      ),
    );
  }

  Widget _buildPresentationContent() => Expanded(
        child: PageView.builder(
          physics: const PageScrollPhysics(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            final presentationSteps = _presentationStepsProvider.provide();
            return (index < presentationSteps.length) ? _buildPresentationStep(context, presentationSteps[index]) : null;
          },
        ),
      );

  Widget _buildPresentationStep(BuildContext context, PresentationStep presentationStep) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: presentationStep.presentationImageType.getImage()),
        Column(
          children: [
            const SizedBox(height: _Constants.presentationStepVerticalSpacing),
            Text(
              presentationStep.title,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: _Constants.presentationStepVerticalSpacing),
            Text(presentationStep.description),
            const SizedBox(height: _Constants.presentationStepVerticalSpacing),
          ],
        )
      ],
    );
  }

  void _goNextPage() => _goToPage(_controller.page.toInt() + 1);

  void _goToPage(int page) {
    _controller.animateToPage(
      page,
      duration: _Constants.indicatorAnimationDuration,
      curve: Curves.ease,
    );
  }

  void _navigateToHomePage(BuildContext context) {
    context.read<PresentationNotifier>().completePresentation();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
