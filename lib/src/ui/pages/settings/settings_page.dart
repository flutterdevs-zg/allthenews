import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  String _appVersion;
  bool _isDarkModeEnabled = false;
  PopularNewsCriterion _selectedPopularNewsCriterion = PopularNewsCriterion.viewed;

  @override
  void initState() {
    super.initState();
    loadApplicationVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: _Constants.headerVerticalSpacing),
                _buildDarkModeSection(context),
                SizedBox(height: _Constants.sectionVerticalSpacing),
                Divider(),
                SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildPopularSection(context),
                SizedBox(height: _Constants.sectionVerticalSpacing),
                Divider(),
                SizedBox(height: _Constants.sectionVerticalSpacing),
                _buildAboutSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) => AppBar(
        elevation: Dimens.appBarElevation,
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
      );

  Widget _buildHeader(BuildContext context) => Text(
        Strings.of(context).settings,
        style: Theme.of(context).textTheme.headline3,
      );

  Widget _buildDarkModeSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _Constants.sectionLeftSpacing,
        right: _Constants.sectionRightSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSettingsHeader(context, Strings.of(context).darkMode),
          CupertinoSwitch(
            value: _isDarkModeEnabled,
            onChanged: (isSelected) {
              setState(() {
                _isDarkModeEnabled = isSelected;
              });
            },
            activeColor: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
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

  Padding _buildPopularSectionItem(BuildContext context, PopularNewsCriterion popularNewsCriterion) {
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
          SizedBox(width: _Constants.switchLeftSpacing),
          _buildSwitch(popularNewsCriterion == _selectedPopularNewsCriterion, (isSelected) {
            if (isSelected) {
              setState(() {
                _selectedPopularNewsCriterion = popularNewsCriterion;
              });
            }
          }),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
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
                _buildAboutAppText(context, '${UntranslatableStrings.email}: ${UntranslatableStrings.flutterDevsZgEmail}'),
                SizedBox(height: _Constants.aboutSectionItemSpacing),
                _appVersion == null ? null : _buildAboutAppText(context, '${Strings.of(context).version}: $_appVersion'),
                SizedBox(height: _Constants.aboutSectionItemSpacing),
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
      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black54),
  );

  Widget _buildPopularSettingText(BuildContext context, PopularNewsCriterion criterion) =>
      Flexible(
        child: Text(
          criterion.toCriterionName(context),
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildSwitch(bool value, ValueChanged<bool> onChanged) =>
      CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.black54,
      );

//FIXME rozwiązanie do czasu ustalenia architektury
  Future<void> loadApplicationVersion() async {
    final appVersion = await inject<AppInfoRepository>().getAppVersion();
    setState(() {
      _appVersion = appVersion;
    });
  }
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
