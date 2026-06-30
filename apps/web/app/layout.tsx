import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "فهم | Fahem AI",
  description:
    "مساحة تعلم عربية تفاعلية مبنية حصريًا على ملف PDF واحد، بإجابات موثّقة بالصفحات.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ar" dir="rtl">
      <body>{children}</body>
    </html>
  );
}
