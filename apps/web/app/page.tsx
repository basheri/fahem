export default function Home() {
  return (
    <main
      style={{
        minHeight: "100dvh",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        gap: "1rem",
        padding: "2rem",
        textAlign: "center",
      }}
    >
      <h1>فهم</h1>
      <p>
        مساحة تعلم عربية تفاعلية مبنية حصريًا على ملف{" "}
        <span dir="ltr">PDF</span> واحد، بإجابات موثّقة بالصفحات.
      </p>
      <p>الواجهة قيد الإنشاء — المرحلة الأولى: تجهيز البنية المحلية.</p>
    </main>
  );
}
