const {
  onDocumentWritten,
} = require("firebase-functions/v2/firestore");
const {
  setGlobalOptions,
} = require("firebase-functions/v2/options");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

setGlobalOptions({maxInstances: 10});

exports.calculateProfStats = onDocumentWritten(
    {
      document: "class/{classId}",
      region: "us-central1",
    },
    async (event) => {
      console.log("🔥 Function triggered for class:", event.params.classId);

      const classesSnapshot = await db.collection("classes").get();
      const profSnapshot = await db.collection("profs").get();

      const allProfs = profSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      const allClasses = classesSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      const now = admin.firestore.Timestamp.now().toDate();
      const currentMonth = now.getMonth();
      const currentYear = now.getFullYear();

      for (const prof of allProfs) {
        const profClasses = allClasses.filter(
            (c) => c.profID === prof.id,
        );

        const totalStudents = profClasses.reduce((sum, c) => {
          return sum + ((c.listeleve && c.listeleve.length) || 0);
        }, 0);

        const allDoneSessions = profClasses.filter(
            (c) => c.pointed === true,
        ).length;

        const monthDoneSessions = profClasses.filter((c) => {
          const date = c.dateTime.toDate();
          return (
            c.pointed &&
          date.getMonth() === currentMonth &&
          date.getFullYear() === currentYear
          );
        }).length;

        const classesFailedThisMonth = profClasses.filter((c) => {
          const date = c.dateTime.toDate();
          return (
            !c.pointed &&
          date < now &&
          date.getMonth() === currentMonth &&
          date.getFullYear() === currentYear
          );
        }).length;

        const totalIncome = allDoneSessions * (prof.CoupParClass || 0);

        const stats = {
          totalClasses: profClasses.length,
          totalStudents,
          totalIncome,
          monthDoneSessions,
          allDoneSessions,
          classesFailedThisMonth,
          lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
        };

        await db.collection("profStats").doc(prof.id).set(stats);
      }
    },
);
