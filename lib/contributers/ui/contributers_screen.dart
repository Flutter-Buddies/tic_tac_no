import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github/github.dart';
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
    Stream<Contributor> contributorStream =
        _gitHub.repositories.listContributors(
      RepositorySlug(
        'Flutter-Buddies',
        'tic_tac_no',
      ),
    );

    List<Contributor> contributorsList = <Contributor>[];

    contributorStream.listen((Contributor contributor) {
      setState(() {
        contributorsList.add(contributor);
      });
    });

    contributorsController.add(contributorsList);
  }

  @override
  void initState() {
    getContributersStream();
    super.initState();
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
          "Contributors",
        ),
      ),
      body: StreamBuilder<List<Contributor>>(
        stream: contributorsController.stream,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Contributor>> snapshot,
        ) {
          final List<Contributor> contributorsList = snapshot.data;

          if (contributorsList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return contributorsList.isEmpty
              ? Center(
                  child: Text(
                    "No Contributors 💔",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: contributorsList.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final Contributor contributor = contributorsList[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          contributor.avatarUrl,
                        ),
                      ),
                      title: Text(
                        contributor.login,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        contributor.type,
                        style: TextStyle(
                          color: Color(0xffC3C3C3),
                        ),
                      ),
                      trailing: Text(
                        'Contributions: ${contributor.contributions}',
                      ),
                      onTap: () async {
                        print(contributor.htmlUrl);
                        await Utils.launchUrl(contributor.htmlUrl);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
