import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
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
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsNotifier _settingsNotifier = inject<SettingsNotifier>();

  @override
  void initState() {
    super.initState();
    _settingsNotifier.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _settingsNotifier,
      builder: (providerContext, child) {
        final state = providerContext.select((SettingsNotifier notifier) => notifier.viewState);

        if (state.isLoading) {
          return _buildProgressIndicator();
        } else {
          return _buildSettingsScreen(state);
        }
      },
    );
  }

  Widget _buildProgressIndicator() => const Center(child: CircularProgressIndicator());

  Widget _buildSettingsScreen(SettingsViewState state) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: NyTimesAppBar(
        title: Strings.current.settings,
        hasBackButton: true,
        backButtonAction: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _Constants.headerVerticalSpacing),
                _buildDarkModeSection(state),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                const Divider(),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildPopularSection(state),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                const Divider(),
                const SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildAboutSection(state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDarkModeSection(SettingsViewState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSettingsHeader(Strings.current.darkMode),
          CupertinoSwitch(
            value: state.isDarkModeEnabled,
            onChanged: (isSelected) {
              _settingsNotifier.selectDarkMode(
                isSelected: isSelected,
                read: context.read,
              );
            },
            activeColor: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection(SettingsViewState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsHeader(Strings.current.popular),
          Column(
            children: PopularNewsCriterion.values.map((criterion) {
              return _buildPopularSectionItem(state, criterion);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Padding _buildPopularSectionItem(
      SettingsViewState state, PopularNewsCriterion popularNewsCriterion) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionItemLeftSpacing,
        top: _Constants.sectionItemTopSpacing,
        bottom: _Constants.sectionItemBottomSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPopularSettingText(popularNewsCriterion),
          const SizedBox(width: _Constants.switchLeftSpacing),
          _buildSwitch(popularNewsCriterion == state.selectedPopularNewsCriterion, (isSelected) {
            if (isSelected) {
              _settingsNotifier.selectPopularNewsCriterion(popularNewsCriterion);
            }
          }),
        ],
      ),
    );
  }

  Widget _buildAboutSection(SettingsViewState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingsHeader(Strings.current.aboutApp),
          Padding(
            padding: const EdgeInsets.only(
              left: _Constants.sectionItemLeftSpacing,
              top: _Constants.sectionItemTopSpacing,
              bottom: _Constants.sectionItemBottomSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAboutAppText(
                    '${UntranslatableStrings.email}: ${UntranslatableStrings.flutterDevsZgEmail}'),
                const SizedBox(height: _Constants.aboutSectionItemSpacing),
                _buildAboutAppText('${Strings.current.version}: ${state.appVersion}'),
                const SizedBox(height: _Constants.aboutSectionItemSpacing),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsHeader(String text) => Text(
        text,
        style: Theme.of(context).textTheme.headline4,
      );

  Widget _buildAboutAppText(String text) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).textTheme.caption.color),
      );

  Widget _buildPopularSettingText(PopularNewsCriterion criterion) => Flexible(
        child: Text(
          criterion.toCriterionName(),
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildSwitch(bool value, ValueChanged<bool> onChanged) => CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).accentColor,
      );
}

extension on PopularNewsCriterion {
  String toCriterionName() {
    switch (this) {
      case PopularNewsCriterion.viewed:
        return Strings.current.viewed;
      case PopularNewsCriterion.shared:
        return Strings.current.shared;
      case PopularNewsCriterion.emailed:
        return Strings.current.emailed;
    }
    return '';
  }
}
