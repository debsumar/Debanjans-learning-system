/* Authoritative metadata source for Debanjan's Learning System.
   Pages remain fully static and do NOT read this file at runtime because readers must not need JavaScript.
   This file exists so tooling and future generation can validate pages against one source.
   It is safe to load via a classic script if a future feature needs it. */
(function(){
  window.LEARNING_SYSTEM = {
    platform: {
      siteName: "Debanjan's Learning System",
      version: "1.0.0",
      storageKey: "dls-theme",
      sticky: { token: "--sticky", value: "92px" },
      depth: { root: 0, topic: 2, rootAssets: "assets/", topicAssets: "../../assets/" }
    },
    topics: [
      {
        slug: "az-900",
        title: "AZ-900",
        description: "Self-contained Microsoft Azure certification notes for offline study.",
        accent: {
          dark: { accent: "#d97757", soft: "#d4a27f", dim: "rgba(217, 119, 87, .10)" },
          light: { accent: "#b3552d", soft: "#8a4522", dim: "rgba(179, 85, 45, .08)" }
        },
        pillLabels: ["12 pages", "Microsoft Azure"],
        pageCount: 12,
        chapterCount: 11,
        hubPath: "topics/az-900/index.html",
        chapters: [
          { file: "01-cloud-computing.html", title: "Describe cloud computing", domain: "Describe cloud concepts", weight: "25-30%" },
          { file: "02-benefits.html", title: "Describe the benefits of using cloud services", domain: "Describe cloud concepts", weight: "25-30%" },
          { file: "03-service-types.html", title: "Describe cloud service types", domain: "Describe cloud concepts", weight: "25-30%" },
          { file: "04-core-architecture.html", title: "Describe the core architectural components of Azure", domain: "Describe Azure architecture and services", weight: "35-40%" },
          { file: "05-compute-networking.html", title: "Describe Azure compute and networking services", domain: "Describe Azure architecture and services", weight: "35-40%" },
          { file: "06-storage.html", title: "Describe Azure storage services", domain: "Describe Azure architecture and services", weight: "35-40%" },
          { file: "07-identity-security.html", title: "Describe Azure identity, access, and security", domain: "Describe Azure architecture and services", weight: "35-40%" },
          { file: "08-cost-management.html", title: "Describe cost management in Azure", domain: "Describe Azure management and governance", weight: "30-35%" },
          { file: "09-governance-compliance.html", title: "Describe features and tools in Azure for governance and compliance", domain: "Describe Azure management and governance", weight: "30-35%" },
          { file: "10-management-deployment.html", title: "Describe features and tools for managing and deploying Azure resources", domain: "Describe Azure management and governance", weight: "30-35%" },
          { file: "11-monitoring.html", title: "Describe monitoring tools in Azure", domain: "Describe Azure management and governance", weight: "30-35%" }
        ]
      }
    ]
  };
})();
