/*
  Pages do NOT read this file at runtime because readers must not need JavaScript.
  assets/study.js is the sole optional consumer.
  Classic script only: one global, no module loading, no build step.
*/
globalThis.LEARNING_SYSTEM = {
  topics: [
    { slug: "az-900", hubPath: "topics/az-900/index.html" }
  ],

  /* 1. CERTIFICATION MANIFEST */
  manifest: {
    vendor: "Microsoft",
    examCode: "AZ-900",
    displayName: "Azure Fundamentals",
    skillsMeasuredAsOf: "July 20, 2026",
    officialStudyGuideUrl: "https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-900",
    domains: [
      { id: "d1", name: "Cloud concepts", weight: "25-30%" },
      { id: "d2", name: "Azure architecture and services", weight: "35-40%" },
      { id: "d3", name: "Management and governance", weight: "30-35%" }
    ]
  },

  /* 2. OBJECTIVE REGISTRY. text is copied verbatim from skills lists. */
  objectives: [
    { id: "az900-c01-o1", text: "Define cloud computing", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o2", text: "Describe the shared responsibility model", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o3", text: "Define cloud models, including public, private, and hybrid", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o4", text: "Identify appropriate use cases for each cloud model", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o5", text: "Describe the consumption-based model", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o6", text: "Compare cloud pricing models", domain: "d1", chapter: "c01", confusionSets: [] },
    { id: "az900-c01-o7", text: "Describe serverless", domain: "d1", chapter: "c01", confusionSets: ["iaas-paas-saas"] },

    { id: "az900-c02-o1", text: "Describe the benefits of high availability and scalability in the cloud", domain: "d1", chapter: "c02", confusionSets: [] },
    { id: "az900-c02-o2", text: "Describe the benefits of reliability and predictability in the cloud", domain: "d1", chapter: "c02", confusionSets: [] },
    { id: "az900-c02-o3", text: "Describe the benefits of security and governance in the cloud", domain: "d1", chapter: "c02", confusionSets: [] },
    { id: "az900-c02-o4", text: "Describe the benefits of manageability in the cloud", domain: "d1", chapter: "c02", confusionSets: [] },

    { id: "az900-c03-o1", text: "Describe infrastructure as a service (IaaS)", domain: "d1", chapter: "c03", confusionSets: ["iaas-paas-saas"] },
    { id: "az900-c03-o2", text: "Describe platform as a service (PaaS)", domain: "d1", chapter: "c03", confusionSets: ["iaas-paas-saas"] },
    { id: "az900-c03-o3", text: "Describe software as a service (SaaS)", domain: "d1", chapter: "c03", confusionSets: ["iaas-paas-saas"] },
    { id: "az900-c03-o4", text: "Identify appropriate use cases for each cloud service type (IaaS, PaaS, and SaaS)", domain: "d1", chapter: "c03", confusionSets: ["iaas-paas-saas"] },

    { id: "az900-c04-o1", text: "Describe Azure regions, region pairs, and sovereign regions", domain: "d2", chapter: "c04", confusionSets: ["region-pair-zone"] },
    { id: "az900-c04-o2", text: "Describe availability zones", domain: "d2", chapter: "c04", confusionSets: ["availability-set-zone", "region-pair-zone"] },
    { id: "az900-c04-o3", text: "Describe Azure datacenters", domain: "d2", chapter: "c04", confusionSets: ["region-pair-zone"] },
    { id: "az900-c04-o4", text: "Describe Azure resources and resource groups", domain: "d2", chapter: "c04", confusionSets: ["subscription-resource-group-management-group"] },
    { id: "az900-c04-o5", text: "Describe subscriptions", domain: "d2", chapter: "c04", confusionSets: ["subscription-resource-group-management-group"] },
    { id: "az900-c04-o6", text: "Describe management groups", domain: "d2", chapter: "c04", confusionSets: ["subscription-resource-group-management-group"] },
    { id: "az900-c04-o7", text: "Describe the hierarchy of resource groups, subscriptions, and management groups", domain: "d2", chapter: "c04", confusionSets: ["subscription-resource-group-management-group"] },

    { id: "az900-c05-o1", text: "Compare compute types, including containers, virtual machines, and functions", domain: "d2", chapter: "c05", confusionSets: [] },
    { id: "az900-c05-o2", text: "Describe virtual machine options, including Azure virtual machines, Azure Virtual Machine Scale Sets, availability sets, and Azure Virtual Desktop", domain: "d2", chapter: "c05", confusionSets: ["availability-set-zone"] },
    { id: "az900-c05-o3", text: "Describe the resources required for virtual machines", domain: "d2", chapter: "c05", confusionSets: [] },
    { id: "az900-c05-o4", text: "Describe application hosting options, including web apps, containers, and virtual machines", domain: "d2", chapter: "c05", confusionSets: [] },
    { id: "az900-c05-o5", text: "Describe virtual networking, including the purpose of Azure virtual networks, subnets, peering, Azure DNS, Azure VPN Gateway, and ExpressRoute", domain: "d2", chapter: "c05", confusionSets: ["vpn-gateway-expressroute"] },
    { id: "az900-c05-o6", text: "Define public and private endpoints", domain: "d2", chapter: "c05", confusionSets: ["public-private-endpoint"] },

    { id: "az900-c06-o1", text: "Compare Azure Storage services", domain: "d2", chapter: "c06", confusionSets: ["blob-files"] },
    { id: "az900-c06-o2", text: "Describe storage tiers", domain: "d2", chapter: "c06", confusionSets: [] },
    { id: "az900-c06-o3", text: "Describe redundancy options", domain: "d2", chapter: "c06", confusionSets: [] },
    { id: "az900-c06-o4", text: "Describe storage account options and storage types", domain: "d2", chapter: "c06", confusionSets: [] },
    { id: "az900-c06-o5", text: "Identify options for moving files, including AzCopy, Azure Storage Explorer, and Azure File Sync", domain: "d2", chapter: "c06", confusionSets: [] },
    { id: "az900-c06-o6", text: "Describe migration options, including Azure Migrate and Azure Data Box", domain: "d2", chapter: "c06", confusionSets: [] },

    { id: "az900-c07-o1", text: "Describe directory services in Azure, including Microsoft Entra ID and Microsoft Entra Domain Services", domain: "d2", chapter: "c07", confusionSets: ["entra-id-domain-services"] },
    { id: "az900-c07-o2", text: "Describe authentication methods in Azure, including single sign-on (SSO), multifactor authentication (MFA), and passwordless", domain: "d2", chapter: "c07", confusionSets: [] },
    { id: "az900-c07-o3", text: "Describe external identities in Azure", domain: "d2", chapter: "c07", confusionSets: [] },
    { id: "az900-c07-o4", text: "Describe Microsoft Entra Conditional Access", domain: "d2", chapter: "c07", confusionSets: [] },
    { id: "az900-c07-o5", text: "Describe Azure role-based access control (RBAC)", domain: "d2", chapter: "c07", confusionSets: ["policy-rbac-locks"] },
    { id: "az900-c07-o6", text: "Describe the concept of Zero Trust", domain: "d2", chapter: "c07", confusionSets: [] },
    { id: "az900-c07-o7", text: "Describe the purpose of the defense-in-depth model", domain: "d2", chapter: "c07", confusionSets: [] },
    { id: "az900-c07-o8", text: "Describe the purpose of Microsoft Defender for Cloud", domain: "d2", chapter: "c07", confusionSets: [] },

    { id: "az900-c08-o1", text: "Describe factors that can affect costs in Azure", domain: "d3", chapter: "c08", confusionSets: [] },
    { id: "az900-c08-o2", text: "Explore the pricing calculator", domain: "d3", chapter: "c08", confusionSets: [] },
    { id: "az900-c08-o3", text: "Describe cost management capabilities in Azure", domain: "d3", chapter: "c08", confusionSets: [] },
    { id: "az900-c08-o4", text: "Describe the purpose of tags", domain: "d3", chapter: "c08", confusionSets: [] },

    { id: "az900-c09-o1", text: "Describe the purpose of Microsoft Purview in Azure", domain: "d3", chapter: "c09", confusionSets: [] },
    { id: "az900-c09-o2", text: "Describe the purpose of Azure Policy", domain: "d3", chapter: "c09", confusionSets: ["policy-rbac-locks"] },
    { id: "az900-c09-o3", text: "Describe the purpose of resource locks", domain: "d3", chapter: "c09", confusionSets: ["policy-rbac-locks"] },

    { id: "az900-c10-o1", text: "Describe the Azure portal", domain: "d3", chapter: "c10", confusionSets: [] },
    { id: "az900-c10-o2", text: "Describe Azure Cloud Shell, Azure CLI, and Azure PowerShell", domain: "d3", chapter: "c10", confusionSets: [] },
    { id: "az900-c10-o3", text: "Describe the purpose of Azure Arc", domain: "d3", chapter: "c10", confusionSets: [] },
    { id: "az900-c10-o4", text: "Describe infrastructure as code (IaC)", domain: "d3", chapter: "c10", confusionSets: [] },
    { id: "az900-c10-o5", text: "Describe Azure Resource Manager (ARM) and ARM templates", domain: "d3", chapter: "c10", confusionSets: [] },

    { id: "az900-c11-o1", text: "Describe the purpose of Azure Advisor", domain: "d3", chapter: "c11", confusionSets: ["monitor-advisor-service-health"] },
    { id: "az900-c11-o2", text: "Describe Azure Service Health", domain: "d3", chapter: "c11", confusionSets: ["monitor-advisor-service-health"] },
    { id: "az900-c11-o3", text: "Describe Azure Monitor, including Log Analytics, Azure Monitor alerts, and Azure Monitor Application Insights", domain: "d3", chapter: "c11", confusionSets: ["monitor-advisor-service-health"] }
  ],

  /* 3. CHAPTER MAP. sectionIds include static skeleton; body sections get archetypes. */
  chapters: [
    { id: "c01", file: "01-cloud-computing.html", title: "Describe cloud computing", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c01-o1", "az900-c01-o2", "az900-c01-o3", "az900-c01-o4", "az900-c01-o5", "az900-c01-o6", "az900-c01-o7"], sectionIds: ["skills", "what", "responsibility", "models", "spending", "serverless", "mcq", "recall"], sectionArchetypes: { what: "concept", responsibility: "comparison", models: "comparison", spending: "decision", serverless: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c02", file: "02-benefits.html", title: "Describe the benefits of using cloud services", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c02-o1", "az900-c02-o2", "az900-c02-o3", "az900-c02-o4"], sectionIds: ["skills", "availability", "reliability", "security", "manageability", "sustainability", "mcq", "recall"], sectionArchetypes: { availability: "concept", reliability: "concept", security: "concept", manageability: "process", sustainability: "decision", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c03", file: "03-service-types.html", title: "Describe cloud service types", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c03-o1", "az900-c03-o2", "az900-c03-o3", "az900-c03-o4"], sectionIds: ["skills", "models", "use-cases", "responsibility", "serverless", "mcq", "recall"], sectionArchetypes: { models: "comparison", "use-cases": "decision", responsibility: "diagram", serverless: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 12 },
    { id: "c04", file: "04-core-architecture.html", title: "Describe the core architectural components of Azure", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c04-o1", "az900-c04-o2", "az900-c04-o3", "az900-c04-o4", "az900-c04-o5", "az900-c04-o6", "az900-c04-o7"], sectionIds: ["skills", "accounts", "geography", "hierarchy", "scopes", "mcq", "recall"], sectionArchetypes: { accounts: "concept", geography: "diagram", hierarchy: "diagram", scopes: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c05", file: "05-compute-networking.html", title: "Describe Azure compute and networking services", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c05-o1", "az900-c05-o2", "az900-c05-o3", "az900-c05-o4", "az900-c05-o5", "az900-c05-o6"], sectionIds: ["skills", "compute", "ai-iot", "hosting", "networking", "endpoints", "mcq", "recall"], sectionArchetypes: { compute: "diagram", "ai-iot": "concept", hosting: "comparison", networking: "diagram", endpoints: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c06", file: "06-storage.html", title: "Describe Azure storage services", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c06-o1", "az900-c06-o2", "az900-c06-o3", "az900-c06-o4", "az900-c06-o5", "az900-c06-o6"], sectionIds: ["skills", "services", "tiers", "redundancy", "movement", "mcq", "recall"], sectionArchetypes: { services: "comparison", tiers: "decision", redundancy: "diagram", movement: "process", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c07", file: "07-identity-security.html", title: "Describe Azure identity, access, and security", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c07-o1", "az900-c07-o2", "az900-c07-o3", "az900-c07-o4", "az900-c07-o5", "az900-c07-o6", "az900-c07-o7", "az900-c07-o8"], sectionIds: ["skills", "directory", "access", "trust", "encryption", "defender", "mcq", "recall"], sectionArchetypes: { directory: "concept", access: "decision", trust: "diagram", encryption: "concept", defender: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 12 },
    { id: "c08", file: "08-cost-management.html", title: "Describe cost management in Azure", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c08-o1", "az900-c08-o2", "az900-c08-o3", "az900-c08-o4"], sectionIds: ["skills", "factors", "tools", "tags", "confusions", "mcq", "recall"], sectionArchetypes: { factors: "concept", tools: "worked-scenario", tags: "process", confusions: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c09", file: "09-governance-compliance.html", title: "Describe features and tools in Azure for governance and compliance", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c09-o1", "az900-c09-o2", "az900-c09-o3"], sectionIds: ["skills", "purview", "policy", "locks", "service-trust", "discrimination", "mcq", "recall"], sectionArchetypes: { purview: "concept", policy: "decision", locks: "callout", "service-trust": "concept", discrimination: "diagram", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c10", file: "10-management-deployment.html", title: "Describe features and tools for managing and deploying Azure resources", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c10-o1", "az900-c10-o2", "az900-c10-o3", "az900-c10-o4", "az900-c10-o5"], sectionIds: ["skills", "interfaces", "arc", "iac", "confusions", "mcq", "recall"], sectionArchetypes: { interfaces: "comparison", arc: "concept", iac: "diagram", confusions: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c11", file: "11-monitoring.html", title: "Describe monitoring tools in Azure", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c11-o1", "az900-c11-o2", "az900-c11-o3"], sectionIds: ["skills", "trio", "monitor", "telemetry", "tables", "advisor", "mcq", "recall"], sectionArchetypes: { trio: "comparison", monitor: "concept", telemetry: "diagram", tables: "comparison", advisor: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 }
  ],

  /* 4. SECTION ARCHETYPE ENUM. Closed list; definitions are one line each. */
  sectionArchetypes: {
    enum: ["concept", "process", "comparison", "decision", "worked-scenario", "callout", "diagram", "mcq-set", "active-recall"],
    definitions: {
      concept: "Defines one idea, boundary, or service.",
      process: "Shows ordered steps from inputs to outputs.",
      comparison: "Contrasts choices using explicit discriminators.",
      decision: "Maps a stated scenario and constraints to a choice.",
      "worked-scenario": "Walks through one concrete problem to its result.",
      callout: "Highlights a short warning, distinction, or rule.",
      diagram: "Explains relationships through a structured visual.",
      "mcq-set": "Presents multiple-choice practice items.",
      "active-recall": "Requires an attempt before revealing an answer."
    }
  },

  /* 5. AUTHORED COMPONENT CATALOGUE. Markup contracts are source of truth. */
  componentCatalogue: {
    glossaryAnchorRule: "Slug is g- plus lowercase ASCII term words joined by hyphens; chapter hrefs use glossary.html#g-... and resolve to glossary dt ids.",
    tldr: {
      purpose: "Summary-first mental-model card.",
      requiredMarkup: "section.card.tldr#tldr containing h2 and one ul with li bullets.",
      invariants: ["Exactly one per chapter.", "First section inside main.", "Contains 4-6 rule-and-boundary li bullets.", "nav.toc contains a link to #tldr."]
    },
    myth: {
      purpose: "Misconception-closure callout in the .cal family.",
      requiredMarkup: "A .cal.myth callout containing one span.lbl and closure prose.",
      invariants: ["Closes a wrong inference, distinct from .cal.confuse which states a rule.", "At most 3 per chapter."]
    },
    steps: {
      purpose: "Ordered causal sequence readable with JavaScript disabled.",
      requiredMarkup: "ol.steps containing ordered li elements, each with one native details element.",
      invariants: ["Every li contains a details element.", "Exactly one details is open, and it is the first.", "Sequence meaning remains in native HTML with JS off."]
    },
    "glossary-link": {
      purpose: "First substantive prose use of a glossary term.",
      requiredMarkup: "An a href=glossary.html#g-slug link around the first substantive prose term.",
      invariants: ["Never in a heading, table header, summary, MCQ stem or option, or the TL;DR.", "Target slug resolves to a glossary dt id."]
    },
    "study-brief": {
      purpose: "Portable study brief and due-review copy controls.",
      requiredMarkup: "study.js builds a brief and renders Copy study brief and Copy due-review list controls.",
      invariants: ["Classic optional script only.", "No module syntax, network call, or variable declaration."]
    }
  },

  /* 6. QUESTION SCHEMA. Existing pages supply items; registry declares contract only. */
  questionSchema: {
    requiredFields: ["itemId", "objectiveIds", "bloom", "stem", "options", "key", "keyRationale", "distractorRationales"],
    bloom: ["remember", "understand", "apply", "analyze"],
    options: { count: 4, itemShape: "four answer strings" },
    distractorRationales: "One rationale per wrong option.",
    optionalFields: ["misconceptionTag"],
    counts: {
      mcqTotal: 110,
      recallTotal: 114,
      perChapter: {
        c01: { mcq: 10, recall: 10 }, c02: { mcq: 10, recall: 10 }, c03: { mcq: 10, recall: 12 },
        c04: { mcq: 10, recall: 10 }, c05: { mcq: 10, recall: 10 }, c06: { mcq: 10, recall: 10 },
        c07: { mcq: 10, recall: 12 }, c08: { mcq: 10, recall: 10 }, c09: { mcq: 10, recall: 10 },
        c10: { mcq: 10, recall: 10 }, c11: { mcq: 10, recall: 10 }
      }
    }
  },

  /* 7. DIAGRAM CATALOGUE. Fifteen diagrams, seven archetypes. */
  diagramCatalogue: {
    archetypes: {
      "flow-chain": {
        count: 6,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c01", section: "responsibility", label: "Shared responsibility progression from on-premises to SaaS" }, { chapter: "c06", section: "redundancy", label: "Azure Storage redundancy options and failure scopes" }, { chapter: "c07", section: "access", label: "Identity authentication, Conditional Access, and RBAC authorization flow" }, { chapter: "c08", section: "tools", label: "Azure cost lifecycle from estimation through deployment, analysis, optimization, tagging, and reporting." }, { chapter: "c10", section: "iac", label: "Azure management surfaces funnel through Azure Resource Manager, while data plane calls use resource endpoints." }, { chapter: "c11", section: "telemetry", label: "Azure Monitor telemetry sources, analysis, alerts, and health views" }]
      },
      "comparison-columns": {
        count: 2,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c01", section: "models", label: "Public, private, and hybrid cloud model comparison" }, { chapter: "c02", section: "availability", label: "Vertical and horizontal scaling comparison" }]
      },
      matrix: {
        count: 2,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c03", section: "responsibility", label: "Shared responsibility across cloud service models" }, { chapter: "c09", section: "discrimination", label: "Azure governance scopes connected to RBAC, Policy, resource locks, and tags." }]
      },
      "nested-containment": {
        count: 2,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c04", section: "geography", label: "Azure region containing three availability zones and datacenters" }, { chapter: "c07", section: "trust", label: "Defense in depth security layers from physical to data" }]
      },
      "spectrum-axis": {
        count: 1,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c05", section: "compute", label: "Compute deployment units and management comparison" }]
      },
      "network-topology": {
        count: 1,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c05", section: "networking", label: "Virtual network peering and hybrid connectivity" }]
      },
      "hierarchy-tree": {
        count: 1,
        requiredDataFields: ["nodes", "labels", "edges", "groups"],
        geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
        uses: [{ chapter: "c04", section: "hierarchy", label: "Azure management hierarchy from management group to resource" }]
      }
    }
  },

  /* 8. CONFUSION SETS. calloutChapter is source truth; hubLinkTarget is resolved target. */
  confusionSets: [
    { id: "policy-rbac-locks", discriminator: "Policy enforces standards; RBAC grants actions; locks block deletion or changes.", objectiveIds: ["az900-c07-o5", "az900-c09-o2", "az900-c09-o3"], calloutChapter: "c09", hubLinkTarget: "09-governance-compliance.html#discrimination" },
    { id: "monitor-advisor-service-health", discriminator: "Monitor observes workloads; Advisor recommends; Service Health reports Azure incidents and maintenance.", objectiveIds: ["az900-c11-o1", "az900-c11-o2", "az900-c11-o3"], calloutChapter: "c11", hubLinkTarget: "11-monitoring.html#trio" },
    { id: "blob-files", discriminator: "Blob stores object data; Files exposes managed file shares over SMB or NFS.", objectiveIds: ["az900-c06-o1"], calloutChapter: "c06", hubLinkTarget: "06-storage.html#services" },
    { id: "vpn-gateway-expressroute", discriminator: "VPN uses encrypted public internet; ExpressRoute uses private dedicated connectivity.", objectiveIds: ["az900-c05-o5"], calloutChapter: "c05", hubLinkTarget: "05-compute-networking.html#networking" },
    { id: "availability-set-zone", discriminator: "Set spreads VMs across fault/update domains; zone uses separate datacenter locations.", objectiveIds: ["az900-c04-o2", "az900-c05-o2"], calloutChapter: "c05", hubLinkTarget: "05-compute-networking.html#hosting" },
    { id: "subscription-resource-group-management-group", discriminator: "Subscription is billing and access boundary; group organizes resources; management group organizes subscriptions.", objectiveIds: ["az900-c04-o4", "az900-c04-o5", "az900-c04-o6", "az900-c04-o7"], calloutChapter: "c04", hubLinkTarget: "04-core-architecture.html#hierarchy" },
    { id: "public-private-endpoint", discriminator: "Public endpoint uses public IP path; private endpoint maps service to a VNet private IP.", objectiveIds: ["az900-c05-o6"], calloutChapter: "c05", hubLinkTarget: "05-compute-networking.html#endpoints" },
    { id: "iaas-paas-saas", discriminator: "More service means less customer management: infrastructure, platform, then complete application.", objectiveIds: ["az900-c01-o7", "az900-c03-o1", "az900-c03-o2", "az900-c03-o3", "az900-c03-o4"], calloutChapter: "c03", hubLinkTarget: "03-service-types.html#models" },
    { id: "entra-id-domain-services", discriminator: "Entra ID is cloud identity; Domain Services supplies managed domain join, LDAP, and Kerberos/NTLM.", objectiveIds: ["az900-c07-o1"], calloutChapter: "c07", hubLinkTarget: "07-identity-security.html#directory" },
    { id: "region-pair-zone", discriminator: "Region is geographic area; pair is linked-region relationship; zone is isolated datacenter group inside a region.", objectiveIds: ["az900-c04-o1", "az900-c04-o2", "az900-c04-o3"], calloutChapter: "c04", hubLinkTarget: "04-core-architecture.html#geography" }
  ],

  /* STUDY POLICY. Equal chapter practice is not equal exam coverage. */
  studyPolicy: {
    leitner: { 1: 1, 2: 3, 3: 7, 4: 14, 5: 30 },
    confidence: ["low", "medium", "high"],
    reviewGuidance: "Review in proportion to domain weight, then prioritize low confidence and missed items within each domain.",
    domainOrder: ["d2", "d3", "d1"],
    coverageSkew: {
      c09: { objectiveCount: 3, mcqCount: 10, objectiveMapping: { "az900-c09-o2": 8 }, note: "Chapter 09 has three objectives, but ten MCQs; eight map to Azure Policy." },
      policy: "Every chapter gets ten MCQs regardless of domain weight.",
      domainWeights: { d1: "25-30%", d2: "35-40%", d3: "30-35%" }
    }
  }
};
