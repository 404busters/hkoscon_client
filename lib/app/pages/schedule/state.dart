class Conference {
  const Conference(this.days);
  final List<Day> days;

  Conference.fromJson(Map<String, dynamic> data) :
        this((data['days'] as List<dynamic>).map((data) => Day.fromJson(data)).toList());
}

class Day {
  const Day({
    this.day,
    this.date,
    this.timeslots,
  });

  final int day;
  final String date;
  final List<Timeslot> timeslots;

  Day.fromJson(Map<String, dynamic> data) :
        this(
          day: data['day'],
          date: data['date'],
          timeslots: data['timeslots']
              .map<Timeslot>((data) => Timeslot.fromJson(data))
              .toList()
      );
}

class Timeslot {
  const Timeslot({
    this.startTime,
    this.endTime,
    this.events,
  });

  final String startTime;
  final String endTime;
  final List<Event> events;

  Timeslot.fromJson(Map<String, dynamic> data) :
        this(
        startTime: data['startTime'],
        endTime: data['endTime'],
        events: data['events']
            .map<Event>((data) => Event.fromJson(data))
            .toList(),
      );
}

class Event {
  const Event({
    this.topic,
    this.display,
    this.description,
    this.venue,
    this.language,
    this.level,
    this.speakers,
    this.internal,
  });

  final bool topic;
  final String display;
  final String description;
  final Venue venue;
  final String language;
  final String level;
  final List<Speaker> speakers;
  final String internal;

  Event.fromJson(Map<String, dynamic> data):
        this(
        venue: Venue.fromJson(data['venue']),
        speakers: data['speakers']
            .map<Speaker>((data) => Speaker.fromJson(data)).toList(),
        topic: data['topic'] as bool,
        display: data['display'],
        description: data['description'] as String,
        language: data['language'] as String,
        level: data['level'] as String,
        internal: data['internal'],
      );
}

class Venue {
  const Venue(this.name);
  final String name;

  Venue.fromJson(Map<String, dynamic> data): this(data['name']);
}

class Speaker {
  const Speaker({
    this.name,
    this.community,
    this.country,
    this.description,
    this.thumbnail,
  });

  Speaker.fromJson(Map<String, dynamic> data):
        this(
        name: data['name'],
        community: data['community'],
        country: data['country'],
        description: data['description'],
        thumbnail: data['thumbnail'],
      );

  final String name;
  final String community;
  final String country;
  final String description;
  final String thumbnail;
}