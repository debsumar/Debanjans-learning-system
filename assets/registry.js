/*
  Pages do NOT read this file at runtime because readers must not need JavaScript.
  assets/study.js is the sole optional consumer.
  Classic script only: one global, no module loading, no build step.
*/
globalThis.LEARNING_SYSTEM = {
  topics: [
    { slug: "az-900", hubPath: "topics/az-900/index.html" },
    { slug: "ccaf", hubPath: "topics/ccaf/index.html" }
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
    { id: "c01", file: "01-cloud-computing.html", title: "Describe cloud computing", shortTitle: "Cloud computing", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c01-o1", "az900-c01-o2", "az900-c01-o3", "az900-c01-o4", "az900-c01-o5", "az900-c01-o6", "az900-c01-o7"], sectionIds: ["skills", "what", "responsibility", "models", "spending", "serverless", "mcq", "recall"], sectionArchetypes: { what: "concept", responsibility: "comparison", models: "comparison", spending: "decision", serverless: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c02", file: "02-benefits.html", title: "Describe the benefits of using cloud services", shortTitle: "Cloud benefits", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c02-o1", "az900-c02-o2", "az900-c02-o3", "az900-c02-o4"], sectionIds: ["skills", "availability", "reliability", "security", "manageability", "sustainability", "mcq", "recall"], sectionArchetypes: { availability: "concept", reliability: "concept", security: "concept", manageability: "process", sustainability: "decision", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c03", file: "03-service-types.html", title: "Describe cloud service types", shortTitle: "Service types", domain: "d1", weight: "25-30%", objectiveIds: ["az900-c03-o1", "az900-c03-o2", "az900-c03-o3", "az900-c03-o4"], sectionIds: ["skills", "models", "use-cases", "responsibility", "serverless", "mcq", "recall"], sectionArchetypes: { models: "comparison", "use-cases": "decision", responsibility: "diagram", serverless: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 12 },
    { id: "c04", file: "04-core-architecture.html", title: "Describe the core architectural components of Azure", shortTitle: "Core architecture", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c04-o1", "az900-c04-o2", "az900-c04-o3", "az900-c04-o4", "az900-c04-o5", "az900-c04-o6", "az900-c04-o7"], sectionIds: ["skills", "accounts", "geography", "hierarchy", "scopes", "mcq", "recall"], sectionArchetypes: { accounts: "concept", geography: "diagram", hierarchy: "diagram", scopes: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c05", file: "05-compute-networking.html", title: "Describe Azure compute and networking services", shortTitle: "Compute and networking", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c05-o1", "az900-c05-o2", "az900-c05-o3", "az900-c05-o4", "az900-c05-o5", "az900-c05-o6"], sectionIds: ["skills", "compute", "ai-iot", "hosting", "networking", "endpoints", "mcq", "recall"], sectionArchetypes: { compute: "diagram", "ai-iot": "concept", hosting: "comparison", networking: "diagram", endpoints: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c06", file: "06-storage.html", title: "Describe Azure storage services", shortTitle: "Storage", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c06-o1", "az900-c06-o2", "az900-c06-o3", "az900-c06-o4", "az900-c06-o5", "az900-c06-o6"], sectionIds: ["skills", "services", "tiers", "redundancy", "movement", "mcq", "recall"], sectionArchetypes: { services: "comparison", tiers: "decision", redundancy: "diagram", movement: "process", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c07", file: "07-identity-security.html", title: "Describe Azure identity, access, and security", shortTitle: "Identity and security", domain: "d2", weight: "35-40%", objectiveIds: ["az900-c07-o1", "az900-c07-o2", "az900-c07-o3", "az900-c07-o4", "az900-c07-o5", "az900-c07-o6", "az900-c07-o7", "az900-c07-o8"], sectionIds: ["skills", "directory", "access", "trust", "encryption", "defender", "mcq", "recall"], sectionArchetypes: { directory: "concept", access: "decision", trust: "diagram", encryption: "concept", defender: "concept", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 12 },
    { id: "c08", file: "08-cost-management.html", title: "Describe cost management in Azure", shortTitle: "Cost management", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c08-o1", "az900-c08-o2", "az900-c08-o3", "az900-c08-o4"], sectionIds: ["skills", "factors", "tools", "tags", "confusions", "mcq", "recall"], sectionArchetypes: { factors: "concept", tools: "worked-scenario", tags: "process", confusions: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c09", file: "09-governance-compliance.html", title: "Describe features and tools in Azure for governance and compliance", shortTitle: "Governance and compliance", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c09-o1", "az900-c09-o2", "az900-c09-o3"], sectionIds: ["skills", "purview", "policy", "locks", "service-trust", "discrimination", "mcq", "recall"], sectionArchetypes: { purview: "concept", policy: "decision", locks: "callout", "service-trust": "concept", discrimination: "diagram", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c10", file: "10-management-deployment.html", title: "Describe features and tools for managing and deploying Azure resources", shortTitle: "Management and deployment", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c10-o1", "az900-c10-o2", "az900-c10-o3", "az900-c10-o4", "az900-c10-o5"], sectionIds: ["skills", "interfaces", "arc", "iac", "confusions", "mcq", "recall"], sectionArchetypes: { interfaces: "comparison", arc: "concept", iac: "diagram", confusions: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
    { id: "c11", file: "11-monitoring.html", title: "Describe monitoring tools in Azure", shortTitle: "Monitoring", domain: "d3", weight: "30-35%", objectiveIds: ["az900-c11-o1", "az900-c11-o2", "az900-c11-o3"], sectionIds: ["skills", "trio", "monitor", "telemetry", "tables", "advisor", "mcq", "recall"], sectionArchetypes: { trio: "comparison", monitor: "concept", telemetry: "diagram", tables: "comparison", advisor: "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 }
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
    breadcrumb: {
      purpose: "Accessible breadcrumb navigation for topic pages.",
      requiredMarkup: "nav.crumbs[aria-label=Breadcrumb] > ol > li; ancestor levels use a; current leaf uses span[aria-current=page].",
      rootRule: "Root launcher has no breadcrumb; a one-item crumb is noise.",
      depthByPageType: { hub: 2, chapter: 3, review: 3, glossary: 3 },
      leaf: "Leaf is an unlinked span[aria-current=page].",
      separators: "Separators are CSS-generated, never typed in markup.",
      leafSource: "Leaf text must equal the chapter shortTitle.",
      labels: { root: "Learning System", topic: "AZ-900", review: "Review", glossary: "Glossary" }
    },
    "study-brief": {
      purpose: "Portable study brief and due-review copy controls.",
      requiredMarkup: "study.js builds a brief and renders Copy study brief and Copy due-review list controls.",
      invariants: ["Classic optional script only.", "No module syntax, network call, or variable declaration."]
    },
    model: {
      purpose: "Interactive prediction model backed by one readable static outcome matrix.",
      requiredMarkup: "div.model[data-model][data-model-rows][data-model-cols] containing div.tw and one table.t.model-matrix.",
      invariants: ["Matrix is the single source of truth; harness derives interaction from its headers, row headers, and cells.", "JavaScript hardcodes no domain facts; model.js loads after study.js.", "Matrix is rectangular and has at least 2 option rows.", "Matrix has 2-5 distinct non-empty outcome values.", "Table remains visible and readable with JavaScript disabled."],
      shipped: [
        { dataModel: "storage-redundancy", chapter: "c06", page: "06-storage.html", rows: 4, cols: 3 },
        { dataModel: "vm-resilience", chapter: "c05", page: "05-compute-networking.html", rows: 4, cols: 3 },
        { dataModel: "governance-inheritance", chapter: "c09", page: "09-governance-compliance.html", rows: 4, cols: 4 }
      ]
    }
  },

  /* 6. INTERACTIVE MODEL CONTRACT. HTML matrices own all outcome values. */
  interactiveModel: {
    purpose: "Optional prediction controls read static outcome matrices; pages remain complete with JavaScript disabled.",
    sourceOfTruth: "Static HTML table.model-matrix headers, row labels, and cells.",
    script: "assets/model.js",
    requiredMarkup: "div.model[data-model] containing exactly one table.model-matrix with one header row and a tbody.",
    invariants: ["Every registered model maps to one chapter section and one data-model value.", "Registry declares identity and dimensions, not outcome values.", "model.js derives options, scenarios, and outcomes from table.model-matrix cells.", "No model control is required for reading or revealing static table outcomes with JavaScript disabled."],
    models: [
      { id: "vm-resilience", chapter: "c05", section: "hosting", rowCount: 4, columnCount: 3 },
      { id: "storage-redundancy", chapter: "c06", section: "redundancy", rowCount: 4, columnCount: 3 },
      { id: "governance-inheritance", chapter: "c09", section: "discrimination", rowCount: 4, columnCount: 4 }
    ]
  },

  /* 7. QUESTION SCHEMA. Existing pages supply items; registry declares contract only. */
  questionSchema: {
    requiredFields: ["itemId", "objectiveIds", "bloom", "stem", "options", "key", "keyRationale", "distractorRationales"],
    bloom: ["remember", "understand", "apply", "analyze"],
    options: { count: 4, itemShape: "four answer strings" },
    distractorRationales: "One rationale per wrong option.",
    optionalFields: ["misconceptionTag"],
    counts: {
      mcqTotal: 110,
      recallTotal: 114,
      reviewRecallTotal: 22,
      perChapter: {
        c01: { mcq: 10, recall: 10 }, c02: { mcq: 10, recall: 10 }, c03: { mcq: 10, recall: 12 },
        c04: { mcq: 10, recall: 10 }, c05: { mcq: 10, recall: 10 }, c06: { mcq: 10, recall: 10 },
        c07: { mcq: 10, recall: 12 }, c08: { mcq: 10, recall: 10 }, c09: { mcq: 10, recall: 10 },
        c10: { mcq: 10, recall: 10 }, c11: { mcq: 10, recall: 10 }
      }
    }
  },

  /* 8. DIAGRAM CATALOGUE. Fifteen diagrams, seven archetypes. */
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

  /* 9. CONFUSION SETS. calloutChapter is source truth; hubLinkTarget is resolved target. */
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
  },

  /* CCAF is topic-scoped until verifier and optional consumers support multiple topics. */
  topicRegistries: {
    ccaf: {
      manifest: {
        vendor: "Anthropic",
        examCode: "CCA-F",
        displayName: "Claude Certified Architect - Foundations",
        skillsMeasuredAsOf: "UNVERIFIED - needs official exam guide",
        officialStudyGuideUrl: "UNVERIFIED - needs official exam guide",
        domains: [
          { id: "d1", name: "Agentic architecture and orchestration", weight: "UNVERIFIED" },
          { id: "d2", name: "Tool design and MCP integration", weight: "UNVERIFIED" },
          { id: "d3", name: "Claude Code configuration and workflows", weight: "UNVERIFIED" },
          { id: "d4", name: "Prompt engineering and structured output", weight: "UNVERIFIED" },
          { id: "d5", name: "Context management and reliability", weight: "UNVERIFIED" }
        ]
      },

      objectives: [
        { id: "ccaf-c01-o1", text: "Trace a tool-use turn from stop reason through dispatch, correlated result, and terminal response.", domain: "d1", chapter: "c01", confusionSets: ["tool-use-result"] },
        { id: "ccaf-c01-o2", text: "Select structured completion control using stop reason and bounded iteration rather than text parsing.", domain: "d1", chapter: "c01", confusionSets: ["end-turn-text"] },
        { id: "ccaf-c01-o3", text: "Distinguish tool request, tool result, displayed output, and conversation state.", domain: "d1", chapter: "c01", confusionSets: ["tool-use-result", "end-turn-text"] },
        { id: "ccaf-c01-o4", text: "Use tool metadata, input schema, and evidence-first debugging before judging tool behavior.", domain: "d1", chapter: "c01", confusionSets: [] },
        { id: "ccaf-c01-o5", text: "Treat transcript-reported exam format and score constraints as unverified until official guide confirmation.", domain: "d1", chapter: "c01", confusionSets: [] },
        { id: "ccaf-c01-o6", text: "Apply the transcript lab-first study loop: inspect example, implement, then validate behavior.", domain: "d1", chapter: "c01", confusionSets: [] },
        { id: "ccaf-c02-o1", text: "Distinguish code-owned decision trees from model-driven decision ownership.", domain: "d1", chapter: "c02", confusionSets: ["code-model-decision"] },
        { id: "ccaf-c02-o2", text: "Design constrained classification output for code-driven routing.", domain: "d1", chapter: "c02", confusionSets: ["code-model-decision"] },
        { id: "ccaf-c02-o3", text: "Select prompt chaining for fixed work shape and adaptive decomposition for evidence-led work.", domain: "d1", chapter: "c02", confusionSets: ["chain-adaptive"] },
        { id: "ccaf-c02-o4", text: "Select decomposition and coverage-review safeguards for broad work.", domain: "d1", chapter: "c02", confusionSets: ["chain-adaptive"] },
        { id: "ccaf-c03-o1", text: "Define coordinator responsibilities and hub-and-spoke communication boundaries.", domain: "d1", chapter: "c03", confusionSets: ["coordinator-spoke"] },
        { id: "ccaf-c03-o2", text: "Choose single, sequential, or parallel delegation from dependency and independence.", domain: "d1", chapter: "c03", confusionSets: ["parallel-sequential"] },
        { id: "ccaf-c03-o3", text: "Design non-overlapping partitions with one routing owner and explicit scope boundaries.", domain: "d1", chapter: "c03", confusionSets: ["partition-selection"] },
        { id: "ccaf-c03-o4", text: "Apply explicit context handoff and isolated sub-agent/tool boundaries.", domain: "d1", chapter: "c03", confusionSets: ["coordinator-spoke"] },
        { id: "ccaf-c04-o1", text: "Implement coverage evaluation, gap-only refinement, bounded attempts, and finalization gates.", domain: "d1", chapter: "c04", confusionSets: ["retry-recovery"] },
        { id: "ccaf-c04-o2", text: "Preserve structured sub-agent success, empty-result, partial-result, and failure context.", domain: "d1", chapter: "c04", confusionSets: ["retry-recovery"] },
        { id: "ccaf-c04-o3", text: "Design auditability with scoped calls, inputs/outputs, errors, latency, IDs, and coverage evidence.", domain: "d1", chapter: "c04", confusionSets: [] },
        { id: "ccaf-c04-o4", text: "Reconcile interrupted task state and resume durable work beyond a happy-path smoke test.", domain: "d1", chapter: "c04", confusionSets: ["retry-recovery"] },
        { id: "ccaf-c05-o1", text: "Use positive, negative, and scored examples to constrain output without claiming truth guarantees.", domain: "d4", chapter: "c05", confusionSets: [] },
        { id: "ccaf-c05-o2", text: "Write specific, bounded instructions that reduce false positives and review burden.", domain: "d4", chapter: "c05", confusionSets: [] },
        { id: "ccaf-c05-o3", text: "Separate schema/syntax validation from semantic, business-rule, and human quality validation.", domain: "d4", chapter: "c05", confusionSets: ["schema-semantic"] },
        { id: "ccaf-c05-o4", text: "Design independent review and confidence-calibrated human review using segmented evidence.", domain: "d4", chapter: "c05", confusionSets: ["self-independent-review"] },
        { id: "ccaf-c06-o1", text: "Choose least-scope tool capability for read, search, edit, shell, or delegated work.", domain: "d2", chapter: "c06", confusionSets: [] },
        { id: "ccaf-c06-o2", text: "Interpret JSON Schema types, enums, nested structures, and required fields for tool arguments.", domain: "d2", chapter: "c06", confusionSets: [] },
        { id: "ccaf-c06-o3", text: "Select `auto`, `any`, named tool, or `none` while controlling named-tool loop risk.", domain: "d2", chapter: "c06", confusionSets: ["any-named-tool"] },
        { id: "ccaf-c06-o4", text: "Distinguish MCP discovery, resources, and tools without overstating resource immutability.", domain: "d2", chapter: "c06", confusionSets: ["resource-tool"] },
        { id: "ccaf-c07-o1", text: "Preserve claim provenance with structured finding, source, location, excerpt, and confidence fields.", domain: "d5", chapter: "c07", confusionSets: ["provenance-confidence"] },
        { id: "ccaf-c07-o2", text: "Preserve claim-source mappings and expose credible conflicts during synthesis.", domain: "d5", chapter: "c07", confusionSets: ["provenance-confidence"] },
        { id: "ccaf-c07-o3", text: "Mitigate precision loss, lost-in-the-middle risk, and oversized tool output.", domain: "d5", chapter: "c07", confusionSets: [] },
        { id: "ccaf-c07-o4", text: "Use persisted facts, findings, scratchpads, and manifests without treating them as interchangeable.", domain: "d5", chapter: "c07", confusionSets: ["findings-manifest"] },
        { id: "ccaf-c08-o1", text: "Describe Claude Code as a context-action-verification coding harness.", domain: "d3", chapter: "c08", confusionSets: ["claude-code-sdk"] },
        { id: "ccaf-c08-o2", text: "Choose transcript-described model options for task complexity, speed, long context, and plan/execution split.", domain: "d3", chapter: "c08", confusionSets: [] },
        { id: "ccaf-c08-o3", text: "Separate setup/authentication smoke tests from application/API behavior claims.", domain: "d3", chapter: "c08", confusionSets: ["claude-code-sdk"] },
        { id: "ccaf-c08-o4", text: "Use skills, procedures, and coordinator guidance at their intended boundary.", domain: "d3", chapter: "c08", confusionSets: [] },
        { id: "ccaf-c09-o1", text: "Distinguish new, resumed, forked, rewound, compacted, and cleared session states.", domain: "d3", chapter: "c09", confusionSets: ["fork-resume-rewind", "compact-clear"] },
        { id: "ccaf-c09-o2", text: "Inspect active-session context and decide whether continuity, compaction, or clearing fits.", domain: "d3", chapter: "c09", confusionSets: ["compact-clear"] },
        { id: "ccaf-c09-o3", text: "Select managed, user, project, or local settings by scope, Git treatment, and precedence.", domain: "d3", chapter: "c09", confusionSets: ["project-local"] },
        { id: "ccaf-c09-o4", text: "Verify SDK/session commands, retention, and version-specific capabilities empirically.", domain: "d3", chapter: "c09", confusionSets: ["fork-resume-rewind"] },
        { id: "ccaf-c10-o1", text: "Resolve allow, ask, and deny rules and check alternate tool paths.", domain: "d3", chapter: "c10", confusionSets: ["permission-sandbox"] },
        { id: "ccaf-c10-o2", text: "Distinguish permission authorization from Bash sandbox execution boundary.", domain: "d3", chapter: "c10", confusionSets: ["permission-sandbox"] },
        { id: "ccaf-c10-o3", text: "Select permission mode and path/command matcher scope for stated work.", domain: "d3", chapter: "c10", confusionSets: ["ask-bypass"] },
        { id: "ccaf-c10-o4", text: "Assess bypass risk, least privilege, and disposable-environment controls.", domain: "d3", chapter: "c10", confusionSets: ["ask-bypass"] },
        { id: "ccaf-c11-o1", text: "Use status and debug evidence to diagnose provider, authentication, tool state, and reproducible faults.", domain: "d3", chapter: "c11", confusionSets: [] },
        { id: "ccaf-c11-o2", text: "Treat logs, formatted output, and persisted artifacts as evidence distinct from UI or completion wording.", domain: "d3", chapter: "c11", confusionSets: ["complete-durable"] },
        { id: "ccaf-c11-o3", text: "Evaluate workflow triggers, permissions, secrets, branches, PRs, and latency before automation trust.", domain: "d3", chapter: "c11", confusionSets: [] },
        { id: "ccaf-c11-o4", text: "Validate generated, refactored, or ported implementation against behavior, artifacts, and target SDK.", domain: "d3", chapter: "c11", confusionSets: ["complete-durable"] },
        { id: "ccaf-c12-o1", text: "Define agent identity, description, prompt, model, turns, and allow/disallow tool controls.", domain: "d1", chapter: "c12", confusionSets: ["agent-description-procedure"] },
        { id: "ccaf-c12-o2", text: "Validate SDK field and terminology claims against target language and version.", domain: "d1", chapter: "c12", confusionSets: [] },
        { id: "ccaf-c12-o3", text: "Plan parallel-safe delegation without inferring scheduling or internal-loop visibility.", domain: "d1", chapter: "c12", confusionSets: ["parallel-sequential"] },
        { id: "ccaf-c12-o4", text: "Refactor coordinator responsibilities into testable, human-readable ownership boundaries.", domain: "d1", chapter: "c12", confusionSets: ["coordinator-spoke"] },
        { id: "ccaf-c13-o1", text: "Select asynchronous batch processing when cost matters more than immediacy and correlate work by IDs.", domain: "d2", chapter: "c13", confusionSets: ["batch-custom-id"] },
        { id: "ccaf-c13-o2", text: "Apply escalation, clarification, and progressive state transitions to support-agent scenarios.", domain: "d2", chapter: "c13", confusionSets: ["request-frustration"] },
        { id: "ccaf-c13-o3", text: "Distinguish explicit human request, ambiguity, multiple matches, frustration, and policy-triggered escalation.", domain: "d2", chapter: "c13", confusionSets: ["request-frustration"] }
      ],

      chapters: [
        { id: "c01", file: "01-agent-loops.html", title: "Agent loops and tool-result control", shortTitle: "Agent loops", domain: "d1", weight: "UNVERIFIED", objectiveIds: ["ccaf-c01-o1", "ccaf-c01-o2", "ccaf-c01-o3", "ccaf-c01-o4", "ccaf-c01-o5", "ccaf-c01-o6"], sectionIds: ["skills", "orientation", "stop-reasons", "tool-turn", "loop-exit", "weather-trace", "mcq", "recall"], sectionArchetypes: { orientation: "callout", "stop-reasons": "concept", "tool-turn": "process", "loop-exit": "decision", "weather-trace": "worked-scenario", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 8, recallCount: 8 },
        { id: "c02", file: "02-decision-orchestration.html", title: "Decision ownership and orchestration", shortTitle: "Decision orchestration", domain: "d1", weight: "UNVERIFIED", objectiveIds: ["ccaf-c02-o1", "ccaf-c02-o2", "ccaf-c02-o3", "ccaf-c02-o4"], sectionIds: ["skills", "decision-owner", "routing", "fixed-vs-adaptive", "coverage", "mcq", "recall"], sectionArchetypes: { "decision-owner": "comparison", routing: "decision", "fixed-vs-adaptive": "comparison", coverage: "process", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 7, recallCount: 7 },
        { id: "c03", file: "03-coordinator-design.html", title: "Coordinator and multi-agent design", shortTitle: "Coordinator design", domain: "d1", weight: "UNVERIFIED", objectiveIds: ["ccaf-c03-o1", "ccaf-c03-o2", "ccaf-c03-o3", "ccaf-c03-o4"], sectionIds: ["skills", "hub-spoke", "delegation", "partitioning", "handoff", "mcq", "recall"], sectionArchetypes: { "hub-spoke": "diagram", delegation: "decision", partitioning: "comparison", handoff: "process", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
        { id: "c04", file: "04-reliable-orchestration.html", title: "Reliable orchestration and recovery", shortTitle: "Reliable orchestration", domain: "d1", weight: "UNVERIFIED", objectiveIds: ["ccaf-c04-o1", "ccaf-c04-o2", "ccaf-c04-o3", "ccaf-c04-o4"], sectionIds: ["skills", "refinement", "reports", "observability", "recovery", "mcq", "recall"], sectionArchetypes: { refinement: "process", reports: "comparison", observability: "concept", recovery: "worked-scenario", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 9, recallCount: 9 },
        { id: "c05", file: "05-prompt-output-quality.html", title: "Prompt, output, and review quality", shortTitle: "Prompt and output quality", domain: "d4", weight: "UNVERIFIED", objectiveIds: ["ccaf-c05-o1", "ccaf-c05-o2", "ccaf-c05-o3", "ccaf-c05-o4"], sectionIds: ["skills", "examples", "criteria", "validation", "review", "mcq", "recall"], sectionArchetypes: { examples: "comparison", criteria: "decision", validation: "process", review: "worked-scenario", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 9, recallCount: 9 },
        { id: "c06", file: "06-tools-mcp-structured-output.html", title: "Tools, MCP, and structured output", shortTitle: "Tools and MCP", domain: "d2", weight: "UNVERIFIED", objectiveIds: ["ccaf-c06-o1", "ccaf-c06-o2", "ccaf-c06-o3", "ccaf-c06-o4"], sectionIds: ["skills", "tool-selection", "schemas", "tool-choice", "mcp", "mcq", "recall"], sectionArchetypes: { "tool-selection": "comparison", schemas: "concept", "tool-choice": "decision", mcp: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 10, recallCount: 10 },
        { id: "c07", file: "07-evidence-context.html", title: "Evidence, synthesis, and context control", shortTitle: "Evidence and context", domain: "d5", weight: "UNVERIFIED", objectiveIds: ["ccaf-c07-o1", "ccaf-c07-o2", "ccaf-c07-o3", "ccaf-c07-o4"], sectionIds: ["skills", "findings", "synthesis", "context-loss", "durable-artifacts", "mcq", "recall"], sectionArchetypes: { findings: "concept", synthesis: "process", "context-loss": "callout", "durable-artifacts": "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 9, recallCount: 9 },
        { id: "c08", file: "08-claude-code-workflows.html", title: "Claude Code workflows and model use", shortTitle: "Claude Code workflows", domain: "d3", weight: "UNVERIFIED", objectiveIds: ["ccaf-c08-o1", "ccaf-c08-o2", "ccaf-c08-o3", "ccaf-c08-o4"], sectionIds: ["skills", "agentic-loop", "models", "setup-boundaries", "harness", "mcq", "recall"], sectionArchetypes: { "agentic-loop": "process", models: "decision", "setup-boundaries": "callout", harness: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 7, recallCount: 7 },
        { id: "c09", file: "09-sessions-settings.html", title: "Sessions, context, and settings", shortTitle: "Sessions and settings", domain: "d3", weight: "UNVERIFIED", objectiveIds: ["ccaf-c09-o1", "ccaf-c09-o2", "ccaf-c09-o3", "ccaf-c09-o4"], sectionIds: ["skills", "session-lifecycle", "context", "settings-scopes", "version-checks", "mcq", "recall"], sectionArchetypes: { "session-lifecycle": "diagram", context: "decision", "settings-scopes": "comparison", "version-checks": "callout", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 12, recallCount: 12 },
        { id: "c10", file: "10-permission-safety.html", title: "Permissions, sandboxing, and safe execution", shortTitle: "Permission safety", domain: "d3", weight: "UNVERIFIED", objectiveIds: ["ccaf-c10-o1", "ccaf-c10-o2", "ccaf-c10-o3", "ccaf-c10-o4"], sectionIds: ["skills", "rule-resolution", "sandbox", "modes", "bypass-risk", "mcq", "recall"], sectionArchetypes: { "rule-resolution": "decision", sandbox: "comparison", modes: "comparison", "bypass-risk": "worked-scenario", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 7, recallCount: 7 },
        { id: "c11", file: "11-diagnostics-automation.html", title: "Diagnostics and repository automation", shortTitle: "Diagnostics and automation", domain: "d3", weight: "UNVERIFIED", objectiveIds: ["ccaf-c11-o1", "ccaf-c11-o2", "ccaf-c11-o3", "ccaf-c11-o4"], sectionIds: ["skills", "status-debug", "run-evidence", "actions", "validate-change", "mcq", "recall"], sectionArchetypes: { "status-debug": "process", "run-evidence": "comparison", actions: "worked-scenario", "validate-change": "decision", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 6, recallCount: 6 },
        { id: "c12", file: "12-agent-definitions-delegation.html", title: "Agent definitions and delegation", shortTitle: "Agent delegation", domain: "d1", weight: "UNVERIFIED", objectiveIds: ["ccaf-c12-o1", "ccaf-c12-o2", "ccaf-c12-o3", "ccaf-c12-o4"], sectionIds: ["skills", "agent-definition", "sdk-parity", "delegation", "ownership", "mcq", "recall"], sectionArchetypes: { "agent-definition": "concept", "sdk-parity": "callout", delegation: "diagram", ownership: "comparison", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 6, recallCount: 6 },
        { id: "c13", file: "13-batch-and-escalation.html", title: "Batch operations and human escalation", shortTitle: "Batch and escalation", domain: "d2", weight: "UNVERIFIED", objectiveIds: ["ccaf-c13-o1", "ccaf-c13-o2", "ccaf-c13-o3"], sectionIds: ["skills", "batch", "batch-choice", "escalation", "support-state", "mcq", "recall"], sectionArchetypes: { batch: "process", "batch-choice": "decision", escalation: "decision", "support-state": "diagram", mcq: "mcq-set", recall: "active-recall" }, mcqCount: 4, recallCount: 4 }
      ],

      sectionArchetypes: {
        enum: ["concept", "process", "comparison", "decision", "worked-scenario", "callout", "diagram", "mcq-set", "active-recall"],
        definitions: {
          concept: "Defines one CCAF concept, boundary, or capability.",
          process: "Shows ordered CCAF workflow steps from input to outcome.",
          comparison: "Contrasts CCAF choices using explicit discriminators.",
          decision: "Maps a CCAF scenario and constraints to a choice.",
          "worked-scenario": "Walks through one concrete CCAF problem to its result.",
          callout: "Highlights a short CCAF warning, distinction, or rule.",
          diagram: "Explains CCAF relationships through a structured visual.",
          "mcq-set": "Presents CCAF multiple-choice practice items.",
          "active-recall": "Requires an attempt before revealing a CCAF answer."
        }
      },

      /* AUTHORED COMPONENT CATALOGUE. Markup contracts are source of truth. */
      componentCatalogue: {
        glossaryAnchorRule: "Slug is g- plus lowercase ASCII CCAF term words joined by hyphens; chapter hrefs use glossary.html#g-... and resolve to glossary dt ids.",
        tldr: {
          purpose: "Summary-first CCAF mental-model card.",
          requiredMarkup: "section.card.tldr#tldr containing h2 and one ul with li bullets.",
          invariants: ["Exactly one per CCAF chapter.", "First section inside main.", "Contains 4-6 rule-and-boundary li bullets.", "nav.toc contains a link to #tldr."]
        },
        myth: {
          purpose: "CCAF misconception-closure callout in the .cal family.",
          requiredMarkup: "A .cal.myth callout containing one span.lbl and closure prose.",
          invariants: ["Closes a wrong CCAF inference, distinct from .cal.confuse which states a rule.", "At most 3 per CCAF chapter."]
        },
        steps: {
          purpose: "Ordered CCAF causal sequence readable with JavaScript disabled.",
          requiredMarkup: "ol.steps containing ordered li elements, each with one native details element.",
          invariants: ["Every li contains a details element.", "Exactly one details is open, and it is the first.", "Sequence meaning remains in native HTML with JS off."]
        },
        "glossary-link": {
          purpose: "First substantive prose use of a CCAF glossary term.",
          requiredMarkup: "An a href=glossary.html#g-slug link around the first substantive prose term.",
          invariants: ["Never in a heading, table header, summary, MCQ stem or option, or the TL;DR.", "Target slug resolves to a CCAF glossary dt id."]
        },
        breadcrumb: {
          purpose: "Accessible breadcrumb navigation for CCAF topic pages.",
          requiredMarkup: "nav.crumbs[aria-label=Breadcrumb] > ol > li; ancestor levels use a; current leaf uses span[aria-current=page].",
          rootRule: "Root launcher has no breadcrumb; a one-item crumb is noise.",
          depthByPageType: { hub: 2, chapter: 3, review: 3, glossary: 3 },
          leaf: "Leaf is an unlinked span[aria-current=page].",
          separators: "Separators are CSS-generated, never typed in markup.",
          leafSource: "Leaf text must equal the registered CCAF chapter shortTitle.",
          labels: { root: "Learning System", topic: "CCA-F", review: "Review", glossary: "Glossary" }
        },
        "study-brief": {
          purpose: "Portable CCAF study brief and due-review copy controls.",
          requiredMarkup: "study.js builds a brief and renders Copy study brief and Copy due-review list controls.",
          invariants: ["Classic optional script only.", "No module syntax, network call, or variable declaration."]
        },
        model: {
          purpose: "Interactive CCAF prediction model backed by one readable static outcome matrix.",
          requiredMarkup: "div.model[data-model][data-model-rows][data-model-cols] containing div.tw and one table.t.model-matrix.",
          invariants: ["Matrix is the single source of truth; harness derives interaction from its headers, row headers, and cells.", "JavaScript hardcodes no CCAF domain facts; model.js loads after study.js.", "Matrix is rectangular and has at least 2 option rows.", "Matrix has 2-5 distinct non-empty outcome values.", "Table remains visible and readable with JavaScript disabled."],
          shipped: [
            { dataModel: "ccaf-delegation-mode", chapter: "c03", page: "03-coordinator-design.html", rows: 3, cols: 3 },
            { dataModel: "ccaf-tool-choice", chapter: "c06", page: "06-tools-mcp-structured-output.html", rows: 4, cols: 4 },
            { dataModel: "ccaf-session-action", chapter: "c09", page: "09-sessions-settings.html", rows: 5, cols: 5 }
          ]
        }
      },

      questionSchema: {
        requiredFields: ["itemId", "objectiveIds", "bloom", "stem", "options", "key", "keyRationale", "distractorRationales"],
        bloom: ["remember", "understand", "apply", "analyze"],
        options: { count: 4, itemShape: "four answer strings" },
        distractorRationales: "One rationale per wrong option.",
        optionalFields: ["misconceptionTag"],
        counts: {
          mcqTotal: 104,
          recallTotal: 104,
          reviewRecallTotal: 37,
          perChapter: {
            c01: { mcq: 8, recall: 8 }, c02: { mcq: 7, recall: 7 }, c03: { mcq: 10, recall: 10 }, c04: { mcq: 9, recall: 9 }, c05: { mcq: 9, recall: 9 }, c06: { mcq: 10, recall: 10 }, c07: { mcq: 9, recall: 9 }, c08: { mcq: 7, recall: 7 }, c09: { mcq: 12, recall: 12 }, c10: { mcq: 7, recall: 7 }, c11: { mcq: 6, recall: 6 }, c12: { mcq: 6, recall: 6 }, c13: { mcq: 4, recall: 4 }
          }
        }
      },

      diagramCatalogue: {
        archetypes: {
          "flow-chain": {
            count: 7,
            requiredDataFields: ["nodes", "labels", "edges", "groups"],
            geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
            uses: [
              { chapter: "c01", section: "tool-turn", label: "Tool request, dispatch, correlated result, append, and terminal response" },
              { chapter: "c04", section: "refinement", label: "Initial work, coverage check, gap retry, and terminal gate" },
              { chapter: "c05", section: "validation", label: "Requirement, examples and criteria, validation, and independent review" },
              { chapter: "c07", section: "synthesis", label: "Source, finding, synthesis, and attributed conflict-aware answer" },
              { chapter: "c08", section: "agentic-loop", label: "Gather context, action, verification, and feedback" },
              { chapter: "c11", section: "actions", label: "Trigger, runner, action, and branch or PR inspection" },
              { chapter: "c13", section: "support-state", label: "Bot, triggered, queued, active, and resolved" }
            ]
          },
          "comparison-columns": {
            count: 2,
            requiredDataFields: ["nodes", "labels", "edges", "groups"],
            geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
            uses: [
              { chapter: "c02", section: "decision-owner", label: "Code-owned route versus model-owned next action" },
              { chapter: "c06", section: "mcp", label: "MCP discovery, resource read intent, and tool action intent" }
            ]
          },
          "network-topology": {
            count: 1,
            requiredDataFields: ["nodes", "labels", "edges", "groups"],
            geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
            uses: [
              { chapter: "c03", section: "hub-spoke", label: "Coordinator, isolated spokes, and context and result paths" }
            ]
          },
          "hierarchy-tree": {
            count: 1,
            requiredDataFields: ["nodes", "labels", "edges", "groups"],
            geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
            uses: [
              { chapter: "c09", section: "session-lifecycle", label: "Baseline, resume, fork, compact, clear, and rewind decisions" }
            ]
          },
          "nested-containment": {
            count: 2,
            requiredDataFields: ["nodes", "labels", "edges", "groups"],
            geometryRules: ["connector endpoints terminate exactly on a box face", "horizontal connectors sit at the shared vertical centre of both joined boxes", "vertical connectors sit at the shared horizontal centre of both joined boxes", "arrowhead tip coincides with connector endpoint", "centred labels use text-anchor=middle at the box centre", "labels fit inside their box", "nothing sits outside the viewBox", "no stroke sits exactly on the viewBox edge"],
            uses: [
              { chapter: "c10", section: "sandbox", label: "Permission rule, tool, Bash sandbox, and disposable host" },
              { chapter: "c12", section: "agent-definition", label: "Identity, description, prompt, tools, controls, and model" }
            ]
          }
        }
      },

      confusionSets: [
        { id: "tool-use-result", discriminator: "Request/exposed call versus correlated execution output.", objectiveIds: ["ccaf-c01-o1", "ccaf-c01-o3"], calloutChapter: "c01", hubLinkTarget: "01-agent-loops.html#tool-turn" },
        { id: "end-turn-text", discriminator: "Structured completion versus potentially misleading content.", objectiveIds: ["ccaf-c01-o2", "ccaf-c01-o3"], calloutChapter: "c01", hubLinkTarget: "01-agent-loops.html#loop-exit" },
        { id: "code-model-decision", discriminator: "Who owns next decision.", objectiveIds: ["ccaf-c02-o1", "ccaf-c02-o2"], calloutChapter: "c02", hubLinkTarget: "02-decision-orchestration.html#decision-owner" },
        { id: "chain-adaptive", discriminator: "Fixed order versus evidence-selected work.", objectiveIds: ["ccaf-c02-o3", "ccaf-c02-o4"], calloutChapter: "c02", hubLinkTarget: "02-decision-orchestration.html#fixed-vs-adaptive" },
        { id: "coordinator-spoke", discriminator: "Orchestrates/routes/aggregates versus bounded execution.", objectiveIds: ["ccaf-c03-o1", "ccaf-c03-o4", "ccaf-c12-o4"], calloutChapter: "c03", hubLinkTarget: "03-coordinator-design.html#hub-spoke" },
        { id: "parallel-sequential", discriminator: "Independence versus prior-result dependency.", objectiveIds: ["ccaf-c03-o2", "ccaf-c12-o3"], calloutChapter: "c03", hubLinkTarget: "03-coordinator-design.html#delegation" },
        { id: "partition-selection", discriminator: "Divides selected work versus decides whether work is needed.", objectiveIds: ["ccaf-c03-o3"], calloutChapter: "c03", hubLinkTarget: "03-coordinator-design.html#partitioning" },
        { id: "retry-recovery", discriminator: "Corrects artifact versus resumes interrupted durable task.", objectiveIds: ["ccaf-c04-o1", "ccaf-c04-o2", "ccaf-c04-o4"], calloutChapter: "c04", hubLinkTarget: "04-reliable-orchestration.html#recovery" },
        { id: "schema-semantic", discriminator: "Format contract versus factual/business correctness.", objectiveIds: ["ccaf-c05-o3"], calloutChapter: "c05", hubLinkTarget: "05-prompt-output-quality.html#validation" },
        { id: "self-independent-review", discriminator: "Retained generator history versus fresh context.", objectiveIds: ["ccaf-c05-o4"], calloutChapter: "c05", hubLinkTarget: "05-prompt-output-quality.html#review" },
        { id: "resource-tool", discriminator: "Read-data intent versus action intent; no immutability claim.", objectiveIds: ["ccaf-c06-o4"], calloutChapter: "c06", hubLinkTarget: "06-tools-mcp-structured-output.html#mcp" },
        { id: "any-named-tool", discriminator: "Any listed tool versus one required named tool.", objectiveIds: ["ccaf-c06-o3"], calloutChapter: "c06", hubLinkTarget: "06-tools-mcp-structured-output.html#tool-choice" },
        { id: "provenance-confidence", discriminator: "Claim origin/location versus certainty signal.", objectiveIds: ["ccaf-c07-o1", "ccaf-c07-o2"], calloutChapter: "c07", hubLinkTarget: "07-evidence-context.html#findings" },
        { id: "findings-manifest", discriminator: "Evidence knowledge versus task/recovery state.", objectiveIds: ["ccaf-c07-o4"], calloutChapter: "c07", hubLinkTarget: "07-evidence-context.html#durable-artifacts" },
        { id: "claude-code-sdk", discriminator: "CLI coding harness versus program integration boundary.", objectiveIds: ["ccaf-c08-o1", "ccaf-c08-o3"], calloutChapter: "c08", hubLinkTarget: "08-claude-code-workflows.html#setup-boundaries" },
        { id: "fork-resume-rewind", discriminator: "New branch, continuation, or changed history point.", objectiveIds: ["ccaf-c09-o1", "ccaf-c09-o4"], calloutChapter: "c09", hubLinkTarget: "09-sessions-settings.html#session-lifecycle" },
        { id: "compact-clear", discriminator: "Summarized continuity versus conversation-history removal.", objectiveIds: ["ccaf-c09-o1", "ccaf-c09-o2"], calloutChapter: "c09", hubLinkTarget: "09-sessions-settings.html#context" },
        { id: "project-local", discriminator: "Shared repository convention versus untracked local preference.", objectiveIds: ["ccaf-c09-o3"], calloutChapter: "c09", hubLinkTarget: "09-sessions-settings.html#settings-scopes" },
        { id: "permission-sandbox", discriminator: "Authorization versus Bash execution environment.", objectiveIds: ["ccaf-c10-o1", "ccaf-c10-o2"], calloutChapter: "c10", hubLinkTarget: "10-permission-safety.html#sandbox" },
        { id: "ask-bypass", discriminator: "Auto-deny unless approved versus skip prompts.", objectiveIds: ["ccaf-c10-o3", "ccaf-c10-o4"], calloutChapter: "c10", hubLinkTarget: "10-permission-safety.html#modes" },
        { id: "complete-durable", discriminator: "Reported success versus verified artifact.", objectiveIds: ["ccaf-c11-o2", "ccaf-c11-o4"], calloutChapter: "c11", hubLinkTarget: "11-diagnostics-automation.html#run-evidence" },
        { id: "agent-description-procedure", discriminator: "Routing/invocation label versus executable procedure.", objectiveIds: ["ccaf-c12-o1"], calloutChapter: "c12", hubLinkTarget: "12-agent-definitions-delegation.html#agent-definition" },
        { id: "batch-custom-id", discriminator: "Batch retrieval identity versus request/result correlation.", objectiveIds: ["ccaf-c13-o1"], calloutChapter: "c13", hubLinkTarget: "13-batch-and-escalation.html#batch" },
        { id: "request-frustration", discriminator: "Immediate escalation versus attempt supported solution first.", objectiveIds: ["ccaf-c13-o2", "ccaf-c13-o3"], calloutChapter: "c13", hubLinkTarget: "13-batch-and-escalation.html#escalation" }
      ],

      interactiveModel: {
        purpose: "Optional prediction controls read static outcome matrices; pages remain complete with JavaScript disabled.",
        sourceOfTruth: "Static HTML table.model-matrix headers, row labels, and cells.",
        script: "assets/model.js",
        requiredMarkup: "div.model[data-model] containing exactly one table.model-matrix with one header row and a tbody.",
        invariants: ["Every registered model maps to one chapter section and one data-model value.", "Registry declares identity and dimensions, not outcome values.", "model.js derives options, scenarios, and outcomes from table.model-matrix cells.", "No model control is required for reading or revealing static table outcomes with JavaScript disabled."],
        models: [
          { id: "ccaf-delegation-mode", chapter: "c03", section: "delegation", rowCount: 3, columnCount: 3 },
          { id: "ccaf-tool-choice", chapter: "c06", section: "tool-choice", rowCount: 4, columnCount: 4 },
          { id: "ccaf-session-action", chapter: "c09", section: "context", rowCount: 5, columnCount: 5 }
        ]
      },

      studyPolicy: {
        leitner: { 1: 1, 2: 3, 3: 7, 4: 14, 5: 30 },
        confidence: ["low", "medium", "high"],
        reviewGuidance: "Until official weights confirm, rank due, missed, low-confidence, then high-confidence misses. Do not rank by claimed exam weight. After confirmation, rank confirmed weight, miss rate, then high-confidence misses.",
        /* Provisional order only: PLAN.md documents all CCAF domain weights as UNVERIFIED. */
        domainOrder: ["d1", "d2", "d3", "d4", "d5"],
        coverageSkew: {
          policy: "Practice allocation is provisional and follows source-content mass, not claimed exam weight.",
          domainWeights: { d1: "UNVERIFIED", d2: "UNVERIFIED", d3: "UNVERIFIED", d4: "UNVERIFIED", d5: "UNVERIFIED" }
        }
      }
    }
  },
};
