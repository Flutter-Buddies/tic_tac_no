import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github/github.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tic_tac_no/utils/utils.dart';

class ContributersScreen extends StatefulWidget {
  @override
  _ContributersScreenState createState() => _ContributersScreenState();
}

class _ContributersScreenState extends State<ContributersScreen> {
  final GitHub _gitHub = GitHub();

  final StreamController<List<Contributor>> contributorsController =
      StreamController<List<Contributor>>();

  void getContributersStream() {
    final contributorStream = _gitHub.repositories.listContributors(
      RepositorySlug(
        'Flutter-Buddies',
        'tic_tac_no',
      ),
    );

    final contributorsList = <Contributor>[];

    contributorStream.listen((Contributor contributor) {
      setState(() {
        contributorsList.add(contributor);
      });
    });

    contributorsController.add(contributorsList);
  }

  @override
  void initState() {
    super.initState();
    getContributersStream();
  }

  @override
  void dispose() {
    contributorsController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.contributors_contributors.tr(),
          style: GoogleFonts.cairo(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.github,
            ),
            onPressed: () async {
              await Utils.launchUrl(
                'https://github.com/Flutter-Buddies/tic_tac_no',
              );
            },
          )
        ],
      ),
      body: StreamBuilder<List<Contributor>>(
        stream: contributorsController.stream,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Contributor>> snapshot,
        ) {
          final contributorsList = snapshot.data;

          if (contributorsList == null || contributorsList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return contributorsList.isEmpty
              ? Center(
                  child: Text(
                    LocaleKeys.contributors_no_contributions.tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: contributorsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contributor = contributorsList[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          contributor.avatarUrl ?? '',
                        ),
                      ),
                      title: Text(
                        contributor.login ?? '',
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        contributor.type ?? 'all',
                        style: GoogleFonts.cairo(
                          color: const Color(0xffC3C3C3),
                        ),
                      ),
                      trailing: Text(
                        '${LocaleKeys.contributors_contributions.tr()}: ${contributor.contributions}',
                        style: GoogleFonts.cairo(),
                      ),
                      onTap: () async {
                        final profileUrl = contributor.htmlUrl;
                        print(profileUrl);
                        if (profileUrl != null) {
                          await Utils.launchUrl(profileUrl);
                        }
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
