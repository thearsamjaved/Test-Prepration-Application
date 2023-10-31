class mcqModel {
  final String q;
  final String ans;
  final String a;
  final String b;
  final String c;
  final String d;
  final int qid;
  mcqModel({
    this.a = 'N/A',
    this.b = 'N/A',
    this.c = 'N/A',
    this.d = 'N/A',
    required this.ans,
    required this.q,
    required this.qid,
  });
  factory mcqModel.fromMap(Map<String, dynamic> map) {
    return mcqModel(
        a: map['a'],
        b: map['b'],
        c: map['c'],
        d: map['d'],
        ans: map['ans'],
        q: map['q'],
        qid: map['qid']);
  }
}
