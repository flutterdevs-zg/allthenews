import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const aboutSectionItemSpacing = 10.0;
  static const headerVerticalSpacing = 30.0;
  static const sectionVerticalSpacing = 20.0;
  static const sectionLeftSpacing = 8.0;
  static const sectionRightSpacing = 45.0;
  static const sectionItemBottomSpacing = 12.0;
  static const sectionItemLeftSpacing = 30.0;
  static const sectionItemTopSpacing = 12.0;
  static const switchLeftSpacing = 10.0;
  static const backButtonPadding = 8.0;
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsNotifier>().loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    if (context.select((SettingsNotifier notifier) => notifier.viewState.isLoading)) {
      return _buildProgressIndicator();
    } else {
      return _buildSettingsScreen(context);
    }
  }

  Widget _buildProgressIndicator() => const Center(child: CircularProgressIndicator());

  Widget _buildSettingsScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: _Constants.headerVerticalSpacing),
                _buildDarkModeSection(context),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                const Divider(),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildPopularSection(context),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                const Divider(),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildAboutSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        brightness: Theme.of(context).brightness,
        elevation: Dimens.appBarElevation,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).backgroundColor,
        leading: _buildBackButton(),
      );

  Widget _buildHeader(BuildContext context) => Text(
        Strings.of(context).settings,
        style: Theme.of(context).textTheme.headline3,
      );

  Widget _buildDarkModeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSettingsHeader(context, Strings.of(context).darkMode),
          CupertinoSwitch(
            value:
                context.select((SettingsNotifier notifier) => notifier.viewState.isDarkModeEnabled),
            onChanged: (isSelected) {
              setState(() {
                context.read<SettingsNotifier>().selectDarkMode(
                      isSelected: isSelected,
                      read: context.read,
                    );
              });
            },
            activeColor: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsHeader(context, Strings.of(context).popular),
          Column(
            children: PopularNewsCriterion.values.map((criterion) {
              return _buildPopularSectionItem(context, criterion);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Padding _buildPopularSectionItem(
      BuildContext context, PopularNewsCriterion popularNewsCriterion) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionItemLeftSpacing,
        top: _Constants.sectionItemTopSpacing,
        bottom: _Constants.sectionItemBottomSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPopularSettingText(context, popularNewsCriterion),
          const SizedBox(width: _Constants.switchLeftSpacing),
          _buildSwitch(
              context,
              popularNewsCriterion ==
                  context.select((SettingsNotifier notifier) =>
                      notifier.viewState.selectedPopularNewsCriterion), (isSelected) {
            if (isSelected) {
              setState(() {
                context.read<SettingsNotifier>().selectPopularNewsCriterion(popularNewsCriterion);
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsHeader(context, Strings.of(context).aboutApp),
          Padding(
            padding: const EdgeInsets.only(
              left: _Constants.sectionItemLeftSpacing,
              top: _Constants.sectionItemTopSpacing,
              bottom: _Constants.sectionItemBottomSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAboutAppText(context,
                    '${UntranslatableStrings.email}: ${UntranslatableStrings.flutterDevsZgEmail}'),
                const SizedBox(height: _Constants.aboutSectionItemSpacing),
                _buildAboutAppText(context,
                    '${Strings.of(context).version}: ${context.select((SettingsNotifier notifier) => notifier.viewState.appVersion)}'),
                const SizedBox(height: _Constants.aboutSectionItemSpacing),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsHeader(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.headline4,
      );

  Widget _buildAboutAppText(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).textTheme.caption.color),
      );

  Widget _buildPopularSettingText(BuildContext context, PopularNewsCriterion criterion) => Flexible(
        child: Text(
          criterion.toCriterionName(context),
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildSwitch(BuildContext context, bool value, ValueChanged<bool> onChanged) =>
      CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).accentColor,
      );

  Widget _buildBackButton() => Padding(
        padding: const EdgeInsets.all(_Constants.backButtonPadding),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
      );
}

extension on PopularNewsCriterion {
  String toCriterionName(BuildContext context) {
    switch (this) {
      case PopularNewsCriterion.viewed:
        return Strings.of(context).viewed;
      case PopularNewsCriterion.shared:
        return Strings.of(context).shared;
      case PopularNewsCriterion.emailed:
        return Strings.of(context).emailed;
    }
    return '';
  }
}
