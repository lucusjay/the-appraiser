// LevelData.swift
// The Appraiser — All 10 Cases (Placeholder content; replace images/text with real works later)

import Foundation
import SwiftUI

// swiftlint:disable file_length type_body_length
struct LevelData {
    static let all: [AppraisalCase] = [level1, level2, level3, level4, level5,
                                        level6, level7, level8, level9, level10]

    // ───────────────────────────────────────────────────────────────
    // LEVEL 1 ★☆☆☆☆  "The Van Gogh Problem"
    // Goal: Real or Fake?   Difficulty: Apprentice
    // ───────────────────────────────────────────────────────────────
    static let level1 = AppraisalCase(
        id: 1, levelNumber: 1,
        title: "The Van Gogh Problem",
        difficulty: .apprentice,
        goal: .authenticateRealOrFake,
        startingBudget: 8000,
        clientName: "Martin Holt",
        clientOccupation: "Antiques Dealer",
        clientStory: "I purchased this 'Sunflowers' variant at a small estate sale in Lyon for €40,000. The seller claimed it was a study Van Gogh made before the famous 1888 series. I just need to know if I got a bargain — or made the worst mistake of my career.",
        artwork: ArtworkInfo(
            claimedTitle: "Sunflowers Study (Variant)",
            claimedArtist: "Vincent van Gogh",
            claimedDate: "c. 1887",
            medium: "Oil on canvas",
            dimensions: "60 × 73 cm",
            primaryColor: Color(red: 0.96, green: 0.67, blue: 0.10),
            accentColor: Color(red: 0.0, green: 0.34, blue: 0.64),
            darkColor: Color(red: 0.15, green: 0.12, blue: 0.05),
            artStyle: .swirling
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Brushwork is unnaturally uniform",
                detail: "Van Gogh's signature impasto technique — thick, directional strokes of undiluted paint — is absent. The surface is smooth and mechanically consistent, lacking the sculptural ridges visible in authenticated works. The paint film shows no true impasto buildup.",
                overlayStyle: .magnified
            ),
            .uvLight: ToolFinding(
                tool: .uvLight,
                headline: "Varnish layer fluoresces evenly — too evenly",
                detail: "Authentic 19th-century varnish shows uneven UV fluorescence due to decades of atmospheric exposure and historic spot-cleaning. This canvas glows with perfectly uniform pale green fluorescence, characteristic of a single modern synthetic varnish application.",
                overlayStyle: .uvRevealed
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Anachronistic pigment detected: Phthalo Blue",
                detail: "The blue tones in this painting contain Phthalocyanine Blue (Phthalo Blue), a synthetic pigment first manufactured commercially in 1935. Van Gogh died in 1890. A painting from 1887 cannot contain a pigment that did not exist for another 45 years. This is conclusive evidence of forgery.",
                overlayStyle: .chemicalMapped
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "No documented provenance before 2018",
                detail: "Searches of the Van Gogh Museum Amsterdam records, Christie's and Sotheby's archives, and the authoritative De La Faille catalogue raisonné reveal no record of this work. It first appears in a 2018 German estate sale listing. Legitimate Van Gogh works have traceable ownership histories stretching back decades.",
                overlayStyle: .documentView
            ),
            .xRay: ToolFinding(
                tool: .xRay,
                headline: "Canvas weave is modern synthetic blend",
                detail: "X-radiography reveals a canvas weave pattern consistent with machine-woven synthetic fiber blends common after 1950. 19th-century artists used hand-loomed or early industrial linen or cotton. The support material alone places this canvas in the post-war era.",
                overlayStyle: .xrayRevealed
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Van Gogh: The Life in Letters",
                author: "Dr. Nienke Bakker",
                coverColor: Color(red: 0.8, green: 0.3, blue: 0.1),
                synopsis: "A study of Van Gogh's correspondence with his brother Theo, documenting his intentions, working methods, and the specific palette choices behind the Sunflowers series.",
                pages: [
                    BookPage(title: "The Arles Sunflowers", content: "In August 1888, Van Gogh wrote to Theo: 'I am working with the enthusiasm of a Marseillais eating bouillabaisse.' He described his intention to use 'chrome yellow, nothing but that' — a preference confirmed by scientific analysis of all authenticated Sunflower canvases. His technique involved applying paint directly from the tube onto canvas, building sculptural impasto ridges that catch light dramatically."),
                    BookPage(title: "Van Gogh's Palette", content: "Van Gogh's documented pigments include chrome yellow, viridian green, Prussian blue, lead white, vermilion, and raw sienna. Modern scientific surveys of authenticated works confirm he never used synthetic pigments developed after his death. The Van Gogh Museum Amsterdam has established strict scientific protocols for authentication, including pigment analysis as a primary criterion."),
                    BookPage(title: "Spotting Forgeries", content: "Van Gogh is one of the most forged artists in history, with hundreds of fakes circulating in the market. Key red flags include: absence of true impasto texture, smooth brushwork inconsistent with his known style, synthetic pigments unavailable before 1890, and lack of provenance documentation in the De La Faille catalogue raisonné, the definitive scholarly record of his works.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Post-Impressionism: Colour and Form",
                author: "T.J. Clark",
                coverColor: Color(red: 0.2, green: 0.4, blue: 0.7),
                synopsis: "A broad survey of the Post-Impressionist movement, covering Cézanne, Gauguin, Van Gogh, and Seurat, examining how each artist diverged from Impressionism.",
                pages: [
                    BookPage(title: "Breaking from Impressionism", content: "Post-Impressionism was not a unified movement but a collection of highly individual responses to Impressionism's limitations. Where the Impressionists sought to capture fleeting optical sensation, Van Gogh, Cézanne, and Gauguin each pushed toward something more permanent — structure, emotion, symbolism."),
                    BookPage(title: "Van Gogh's Emotional Colour", content: "Van Gogh used colour expressively rather than descriptively. Yellow, for him, represented joy, sunlight, and divinity. Blue represented infinity and spirituality. His canvases were psychological landscapes as much as physical ones.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Dutch Masters: From Rembrandt to Mondrian",
                author: "Frits Duparc",
                coverColor: Color(red: 0.1, green: 0.3, blue: 0.2),
                synopsis: "Chronicles five centuries of Dutch painting from the Golden Age through early Modernism, exploring the thread of craft and observation that runs through the tradition.",
                pages: [
                    BookPage(title: "The Dutch Tradition", content: "Dutch painting has always prized direct observation of the material world. From Vermeer's meticulous domestic interiors to Van Gogh's urgent expressionism, the Dutch tradition is one of intense looking — of finding transcendence in the visible."),
                    BookPage(title: "Van Gogh's Dutch Roots", content: "Though Van Gogh spent his most productive years in France, his Dutch upbringing shaped his fundamental approach. The dark earth tones of his Nuenen period gave way to Mediterranean brightness, but his commitment to honest, laboured observation never faltered.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. Lena Visscher",
            title: "Senior Curator, Authentication",
            institution: "Van Gogh Museum, Amsterdam",
            specialty: "Post-Impressionist technical analysis",
            opinion: "I haven't examined this work in person, but from the photographs alone I'm skeptical. The brushwork lacks the characteristic torsional energy of Van Gogh's authenticated Sunflower studies. His stroke directions follow the form of each petal — they spiral, they press. This looks applied. That said, I'd need pigment analysis to be certain.",
            caveat: "Without in-person technical examination, I can only go so far. But my gut says: run the chemistry.",
            cost: 1200
        ),
        auctionRecord: "No record found in Christie's, Sotheby's, or Bonhams archives. Absent from the De La Faille catalogue raisonné (definitive record of Van Gogh's authenticated works). First appearance: Maurer & Sohn estate sale, Stuttgart, November 2018, lot 114, estimate €35,000–50,000.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Forgery",
            fullAnswer: "This painting is a modern forgery. The brushwork lacks Van Gogh's characteristic impasto technique, the varnish shows evidence of a single modern application, the canvas weave is synthetic post-1950 material, and — most damningly — the blue pigment is Phthalocyanine Blue, invented in 1935, 45 years after Van Gogh's death.",
            educationalExplanation: "Van Gogh is among the most forged artists of the 20th century. Authenticators rely on three pillars: technical analysis (pigment chemistry, canvas dating), stylistic analysis (his distinctive impasto brushwork), and provenance (documented ownership history). The De La Faille catalogue raisonné is the gold standard reference — if a work isn't in it, extreme skepticism is warranted."
        ),
        choices: ["Authentic Van Gogh", "Forgery", "School of Van Gogh (contemporary copy)", "Authenticity uncertain"],
        correctChoiceIndex: 1,
        successPayout: 6000,
        failurePenalty: 3000,
        baseXP: 100
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 2 ★★☆☆☆  "Water and Light"
    // Goal: Identify the Artist   Difficulty: Journeyman
    // ───────────────────────────────────────────────────────────────
    static let level2 = AppraisalCase(
        id: 2, levelNumber: 2,
        title: "Water and Light",
        difficulty: .journeyman,
        goal: .identifyArtist,
        startingBudget: 10000,
        clientName: "Céleste Moreau",
        clientOccupation: "Estate Lawyer",
        clientStory: "This canvas was found in the attic of a Normandy farmhouse belonging to a recently deceased client. The estate has no documentation. My client believes it may be significant — there's a faint signature under the varnish, but no one can read it. I need a name, or at least a confident attribution.",
        artwork: ArtworkInfo(
            claimedTitle: "Water Garden (unattributed)",
            claimedArtist: "Artist Unknown",
            claimedDate: "c. 1899–1910 (estimated)",
            medium: "Oil on canvas",
            dimensions: "92 × 73 cm",
            primaryColor: Color(red: 0.29, green: 0.61, blue: 0.55),
            accentColor: Color(red: 0.75, green: 0.85, blue: 0.92),
            darkColor: Color(red: 0.05, green: 0.18, blue: 0.22),
            artStyle: .swirling
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Signature partially legible: 'C. Mo—'",
                detail: "Under magnification, a signature in the lower-right corner reads 'C. Mo—' with the remaining letters obscured by accumulated varnish. The brushwork is characteristically broken and dappled — short comma-strokes of pure colour placed side by side rather than blended, a hallmark of French Impressionist technique.",
                overlayStyle: .magnified
            ),
            .uvLight: ToolFinding(
                tool: .uvLight,
                headline: "Varnish patterns consistent with pre-1920 application",
                detail: "UV reveals multiple varnish layers applied at different times, with the earliest layer showing the darkened matte fluorescence characteristic of natural resin varnishes (damar or mastic) aged over a century. Restoration is minimal and confined to the lower-right corner. Period consistent with late 19th / early 20th century.",
                overlayStyle: .uvRevealed
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "Giverny connection: canvas stamp on reverse",
                detail: "A partial canvas maker's stamp on the reverse reads 'Père Tanguy, Paris' — a colourman supply shop frequented by Impressionist painters in Montmartre and later Giverny. The compositional elements — Japanese-influenced bridge, water lily pads, weeping willow reflections — are specific to the water garden at Giverny, Normandy, created and painted obsessively by one artist.",
                overlayStyle: .documentView
            ),
            .infrared: ToolFinding(
                tool: .infrared,
                headline: "No underdrawing — direct painting method",
                detail: "Infrared reveals no preliminary sketch or underdrawing beneath the paint layer. The composition was laid in directly — a practice documented in the late work of Claude Monet, who famously worked increasingly from memory and sensation rather than preparatory studies, particularly in the 1900s water garden series.",
                overlayStyle: .infraredRevealed
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Claude Monet: Water and Light",
                author: "Paul Hayes Tucker",
                coverColor: Color(red: 0.2, green: 0.55, blue: 0.65),
                synopsis: "The definitive study of Monet's late period and his obsessive engagement with the water garden at Giverny, examining the technical evolution of the Nymphéas series.",
                pages: [
                    BookPage(title: "The Giverny Garden", content: "In 1893, Monet purchased land adjacent to his Giverny property and began constructing his now-famous water garden, installing a Japanese-style wooden bridge, diverting a stream to create the pond, and planting water lilies. He painted this garden obsessively for the rest of his life, producing over 250 oil paintings of the water lilies alone. The garden was both his studio and his primary subject."),
                    BookPage(title: "Monet's Signature", content: "Monet typically signed works in the lower corners, either 'Claude Monet' in full or 'C. Monet' in a characteristically hurried script. He rarely signed works he considered unfinished. The abbreviated 'C. Mo—' signature pattern — in this hand — is consistent with authenticated works from his Giverny period (1890–1926)."),
                    BookPage(title: "The Late Style", content: "In his final decades, increasingly affected by cataracts, Monet's brushwork became broader, more gestural, and more abstract. Works from 1900–1910 still retain relatively crisp dappled strokes, while post-1910 works grow dramatically more atmospheric. The broken comma-strokes and pure colour placement visible here are consistent with the c.1900–1910 period.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "The Impressionist Circle: Renoir, Pissarro, Sisley",
                author: "Anne Distel",
                coverColor: Color(red: 0.7, green: 0.3, blue: 0.4),
                synopsis: "Examines the friendships, rivalries, and shared techniques among the core Impressionist group, illuminating how their styles both converged and diverged.",
                pages: [
                    BookPage(title: "Shared Technique", content: "The Impressionists shared a commitment to painting outdoors (en plein air) and a method of applying broken strokes of pure colour to suggest the vibration of light. However, each artist developed a distinctive touch: Renoir's feathery strokes, Pissarro's stippled texture, Sisley's horizontal hatching."),
                    BookPage(title: "Water Subjects", content: "Many Impressionists were drawn to water — its reflections and shimmer perfectly embodied their interest in captured light. Renoir's boating scenes, Sisley's flood paintings, and Pissarro's river views all engage with water as a subject. But none pursued it with the singular dedication of their colleague Claude Monet.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Flowers in Western Art",
                author: "Miranda Beaumont",
                coverColor: Color(red: 0.5, green: 0.7, blue: 0.3),
                synopsis: "A survey of botanical subjects across five centuries of Western painting, from Dutch still life through 20th-century abstraction.",
                pages: [
                    BookPage(title: "The Still Life Tradition", content: "Flowers entered the Western painting tradition primarily through Dutch and Flemish still life of the 17th century. Artists like Jan Davidsz de Heem assembled impossibly abundant floral arrangements — often combining species that bloom in different seasons — to demonstrate virtuosity and to convey themes of abundance and vanitas."),
                    BookPage(title: "Impressionist Gardens", content: "The Impressionists transformed the flower from a studio still life subject into a living, light-filled outdoor environment. Gardens — with their dappled light, seasonal change, and riot of colour — became ideal Impressionist subjects. Monet, Renoir, and Caillebotte all painted their own gardens intensively.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Prof. Marie-Claire Dupont",
            title: "Professor of French Impressionism",
            institution: "École du Louvre, Paris",
            specialty: "Monet and the Giverny Circle",
            opinion: "The palette — those specific greens and blues — and the compositional elements are remarkably consistent with Monet's documented practice at Giverny. The water lily pads, the soft reflections of willow branches, the lack of horizon line... this is Giverny. Whether Monet painted it himself or whether it's a very close study by a follower working on site, I genuinely can't say without examining the signature properly.",
            caveat: "Attribution of Impressionist work is notoriously difficult. There are skilled followers who worked at Giverny, including Blanche Hoschedé-Monet, his stepdaughter. The signature is the key.",
            cost: 1500
        ),
        auctionRecord: "No direct match found. Comparable authenticated Monet water garden paintings (1900–1910, similar scale) have sold: Christie's New York 2019, $18.4M; Sotheby's London 2021, £14.2M. A Giverny-school attribution (follower) would yield approximately $80,000–$150,000.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Claude Monet",
            fullAnswer: "This painting is by Claude Monet, from his Giverny water garden series, c. 1900–1910. The partial signature 'C. Mo—', the Giverny-specific composition (water lily pads, Japanese bridge reflections, willow), the Paris canvas supplier stamp, and the period-consistent dappled Impressionist brushwork all confirm the attribution.",
            educationalExplanation: "Monet created his Giverny water garden in 1893 and spent the remainder of his life painting it, producing over 250 water lily paintings. His late style — increasingly broad, gestural, and abstract — was shaped partly by his worsening cataracts. The garden became an almost meditative subject, leading directly to the monumental Nymphéas murals in the Orangerie, Paris."
        ),
        choices: ["Pierre-Auguste Renoir", "Claude Monet", "Alfred Sisley", "Blanche Hoschedé-Monet (Follower)"],
        correctChoiceIndex: 1,
        successPayout: 8000,
        failurePenalty: 3500,
        baseXP: 150
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 3 ★★☆☆☆  "The Blue Figures"
    // Goal: Identify the Period / Decade   Difficulty: Journeyman
    // ───────────────────────────────────────────────────────────────
    static let level3 = AppraisalCase(
        id: 3, levelNumber: 3,
        title: "The Blue Figures",
        difficulty: .journeyman,
        goal: .identifyDecade,
        startingBudget: 10000,
        clientName: "Sofia Reyes",
        clientOccupation: "Gallery Owner, Barcelona",
        clientStory: "This painting has been in my family for three generations. My grandmother bought it in Barcelona in the 1940s — she said the artist was a young Spaniard who'd just come back from Paris, and that it was 'the most sad and beautiful thing' she'd ever seen. No signature we can find. I'm not asking for a price today. I want to know: when was this painted?",
        artwork: ArtworkInfo(
            claimedTitle: "Café at Night (unattributed)",
            claimedArtist: "Unknown Spanish artist (attributed)",
            claimedDate: "Unknown",
            medium: "Oil on canvas",
            dimensions: "81 × 65 cm",
            primaryColor: Color(red: 0.10, green: 0.22, blue: 0.54),
            accentColor: Color(red: 0.42, green: 0.63, blue: 0.82),
            darkColor: Color(red: 0.04, green: 0.07, blue: 0.18),
            artStyle: .dramaticScene
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Elongated figures and muted blue tones throughout",
                detail: "The human figures are rendered with elongated, attenuated proportions reminiscent of El Greco — a conscious stylistic choice. The palette is almost exclusively cool blue and blue-grey, with the only warm tones appearing in flesh and the distant gas lamp. The paint application is thin and rapid, with visible brushwork.",
                overlayStyle: .magnified
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Pigments consistent with early 1900s",
                detail: "Lead white, Prussian blue, ivory black, yellow ochre. No synthetic pigments (no Phthalo Blue, no titanium white). Binder analysis indicates linseed oil, period-appropriate. Paint chemistry places this work firmly in the 1890–1915 range. The specific blue employed is consistent with Prussian blue, the dominant blue of Spanish and French studios in this period.",
                overlayStyle: .chemicalMapped
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "Barcelona, c. 1940s acquisition — traces to French market",
                detail: "Records confirm the work was sold by a Parisian dealer (Galerie Berthe Weill) between 1901–1904, consistent with your grandmother's account of a 'Barcelona purchase' in that era — Weill was one of few dealers handling Spanish-born Parisian artists at the time. Weill's sales records from that period document several purchases by Spanish collectors visiting Paris.",
                overlayStyle: .documentView
            ),
            .infrared: ToolFinding(
                tool: .infrared,
                headline: "Underdrawing shows initial warmer composition",
                detail: "Infrared reveals a preliminary sketch beneath the paint in which the figures were posed with more animation and the background shows warm ochre tone. The artist made a deliberate choice to paint over a warmer palette with the pervasive blue, suggesting the monochromatic treatment was an intentional artistic statement rather than a limitation.",
                overlayStyle: .infraredRevealed
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Picasso: The Blue and Rose Periods",
                author: "Marilyn McCully",
                coverColor: Color(red: 0.15, green: 0.30, blue: 0.65),
                synopsis: "A focused study of Picasso's early career, from his Barcelona training through the transformative Blue Period (1901–1904) and its transition into the warmer Rose Period.",
                pages: [
                    BookPage(title: "Origins of the Blue Period", content: "The Blue Period (1901–1904) began following the suicide of Picasso's close friend Carlos Casagemas in February 1901. Devastated, Picasso began painting in near-monochromatic blue — a colour he associated with cold, isolation, and melancholy. Subjects were drawn from Parisian outcasts: the poor, the sick, blind beggars, prisoners, and café habitués — people on the margins of society."),
                    BookPage(title: "The Palette", content: "Blue Period paintings are characterised by their oppressive blue tonality, occasionally modulated by blue-green or grey. The only warm accents are confined to skin tones and occasional lamp-light, emphasising the cold desolation of the subjects. Prussian blue, the dominant pigment, was inexpensive and abundantly available — fitting for a nearly destitute young artist."),
                    BookPage(title: "Barcelona and Paris", content: "Picasso moved between Barcelona and Paris during this period, and the Blue Period works reflect both cities' underbellies. In Barcelona he frequented the Els Quatre Gats café — a haunt of Catalan modernists. In Paris he lived in poverty at the Bateau-Lavoir in Montmartre, surrounded by poets, anarchists, and struggling artists. Both worlds provided his subject matter.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Spanish Painting 1850–1950",
                author: "Jonathan Brown",
                coverColor: Color(red: 0.65, green: 0.15, blue: 0.15),
                synopsis: "A comprehensive survey of 19th and early 20th century Spanish painting, examining the transition from academic tradition to modernism.",
                pages: [
                    BookPage(title: "The Barcelona Modernisme", content: "At the turn of the 20th century, Barcelona was the most artistically progressive city in Spain — its Modernisme movement (distinct from French Impressionism) blending Catalan nationalism with Art Nouveau influences. Young artists like Picasso and Juan Gris trained at Barcelona's School of Fine Arts before departing for Paris."),
                    BookPage(title: "Influence of El Greco", content: "Spanish painters of the early 20th century frequently looked back to El Greco (1541–1614) as a proto-modernist ancestor — his elongated figures, spiritual intensity, and unusual palette anticipated later expressionist tendencies. Young Picasso admired El Greco deeply, and El Greco's influence is visible in the attenuated proportions of Blue Period figures.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Café Life in Belle Époque Paris",
                author: "Vanessa Schwartz",
                coverColor: Color(red: 0.4, green: 0.4, blue: 0.2),
                synopsis: "A cultural history of the Parisian café as a social institution in the late 19th and early 20th centuries, from Montmartre cabarets to the literary cafés of Saint-Germain.",
                pages: [
                    BookPage(title: "The Café as Subject", content: "The café occupied a unique place in fin-de-siècle Parisian culture — simultaneously a public and private space, a place of gathering, loneliness, argument, and creativity. Painters from Manet (Le Bar aux Folies-Bergère) to Degas (L'Absinthe) explored the café's ambiguous social register."),
                    BookPage(title: "Artists in Montmartre", content: "Montmartre's cafés and cabarets were the gathering places of struggling artists, poets, and performers. The Moulin Rouge, the Lapin Agile, and dozens of smaller establishments were simultaneously sources of entertainment, artistic inspiration, and economic desperation for many residents of the Butte.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. James Aranda",
            title: "Curator, Modern Spanish Collections",
            institution: "Reina Sofía Museum, Madrid",
            specialty: "Early 20th-century Spanish Modernism",
            opinion: "The emotional register of this work — the deliberate cold palette, the marginal subjects, the attenuated figures — places this squarely in a very specific cultural moment. The early 1900s, specifically the first few years after the century turned. Whether this is by the hand of the famous artist from Málaga or a talented follower working in the same vein, the period is unmistakable.",
            caveat: "Attribution in early Modernism is contentious. Several Barcelona artists painted in similar modes during this period. I'd need technical analysis of the pigments to say more.",
            cost: 1400
        ),
        auctionRecord: "Works in comparable style and period (Spanish, c.1901–1910, blue tonality, café subjects): Christie's 2022, attributed work, £420,000. Authenticated works by the major artist associated with this period regularly exceed $50M at auction. Attribution and authentication are paramount.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "1901–1904 (Blue Period)",
            fullAnswer: "This painting dates to 1901–1904, the Blue Period of Pablo Picasso. The near-monochromatic blue palette, the attenuated El Greco-influenced figures, the marginal café subjects, and the period-consistent pigments (Prussian blue, lead white, no synthetic colours) all point to this specific four-year span in Picasso's early career.",
            educationalExplanation: "Picasso's Blue Period (1901–1904) was triggered by grief over his friend's suicide and his own poverty in Paris. He painted outcasts — the blind, the imprisoned, the hungry — in an oppressive blue palette that expressed collective despair. This period was transformative: it established his departure from academic training and his embrace of personal, emotionally charged subject matter. The Blue Period ended abruptly when he met Fernande Olivier and his fortunes began to improve, transitioning into the warmer, more playful Rose Period."
        ),
        choices: ["1890s (Pre-Impressionism)", "1901–1904 (Blue Period)", "1910s (Cubist era)", "1920s (Surrealist influence)"],
        correctChoiceIndex: 1,
        successPayout: 7500,
        failurePenalty: 3000,
        baseXP: 150
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 4 ★★★☆☆  "The Merchant's Gaze"
    // Goal: Identify Artist & Period   Difficulty: Adept
    // ───────────────────────────────────────────────────────────────
    static let level4 = AppraisalCase(
        id: 4, levelNumber: 4,
        title: "The Merchant's Gaze",
        difficulty: .adept,
        goal: .fullAttribution,
        startingBudget: 14000,
        clientName: "Victor Hendriks",
        clientOccupation: "Private Collector, Bruges",
        clientStory: "This small panel portrait has hung in my family's home for four generations. A great-uncle bought it in 1920 from a Belgian art dealer who called it 'a fine example of the old Flemish style.' We know nothing more specific. I've always suspected it might be something significant — the craftsmanship seems extraordinary. Can you give me a name and a date?",
        artwork: ArtworkInfo(
            claimedTitle: "Portrait of a Merchant (unattributed)",
            claimedArtist: "Unknown Flemish Master",
            claimedDate: "c. 15th century (estimated)",
            medium: "Oil on oak panel",
            dimensions: "33 × 28 cm",
            primaryColor: Color(red: 0.55, green: 0.42, blue: 0.25),
            accentColor: Color(red: 0.82, green: 0.70, blue: 0.45),
            darkColor: Color(red: 0.08, green: 0.06, blue: 0.04),
            artStyle: .portraitBust
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Extraordinary detail: individual hairs, textile weave visible",
                detail: "The level of microscopic detail is breathtaking — individual eyebrow hairs, pores in the skin, the warp and weft of the red fabric. This degree of fine detail was a hallmark of early Netherlandish painting, achieved through a specific layered oil glazing technique that allowed unprecedented transparency and depth. The treatment of the hands, in particular, is masterful.",
                overlayStyle: .magnified
            ),
            .xRay: ToolFinding(
                tool: .xRay,
                headline: "Oak panel; underdrawing in metalpoint or chalk",
                detail: "X-radiography reveals an oak panel support — consistent with Flemish panel painting of the 15th century. The underdrawing, visible in X-ray, is precise and highly detailed, executed in what appears to be metalpoint or silverpoint, a technique associated with workshop practice in the Bruges/Ghent schools of the 1420s–1440s. The lead white ground is evenly applied.",
                overlayStyle: .xrayRevealed
            ),
            .canvasDating: ToolFinding(
                tool: .canvasDating,
                headline: "Dendrochronology: panel oak felled c. 1410–1430",
                detail: "Tree-ring analysis (dendrochronology) of the oak panel dates the wood to trees felled circa 1410–1430, a standard 5–10 year seasoning period placing the painting's creation at approximately 1420–1445. This dating is entirely consistent with the Northern Renaissance period and specifically with the active careers of the major Bruges masters.",
                overlayStyle: .documentView
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Early oil glazing: linseed with lead white ground",
                detail: "Analysis reveals the multi-layer glazing technique specific to early Netherlandish oil painting: a chalk/lead white ground, followed by successive translucent oil glazes in ultramarine (lapis lazuli), vermilion, and lead white highlights. The use of natural ultramarine (lapis lazuli) rather than synthetic alternatives confirms a pre-1700 dating. The paint chemistry is consistent with Bruges workshops, c. 1420–1460.",
                overlayStyle: .chemicalMapped
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "Flemish dealer documentation, early 20th century",
                detail: "Belgian dealer records from 1920 reference a small portrait on panel sold to a Hendriks family, described as 'Flemish, 15th century, quality school.' No attribution to a specific master. The work does not appear in the major pre-20th century auction records, suggesting it remained in private hands — a typical pattern for 15th-century panel paintings that never entered institutional collections.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Jan van Eyck and the Early Netherlandish Masters",
                author: "Maximiliaan Martens",
                coverColor: Color(red: 0.6, green: 0.45, blue: 0.15),
                synopsis: "The authoritative scholarly study of the Bruges school and Jan van Eyck's revolutionary contribution to oil painting technique and portraiture.",
                pages: [
                    BookPage(title: "The Oil Glazing Revolution", content: "Jan van Eyck (c.1390–1441) is traditionally credited with perfecting, if not inventing, the oil glazing technique that transformed Western painting. By building up successive transparent oil layers over a light ground, painters could achieve unprecedented luminosity, depth, and microscopic detail impossible with earlier tempera methods. The technique spread from Bruges throughout Europe within decades."),
                    BookPage(title: "Portrait in the Northern Renaissance", content: "Flemish portraiture of the 15th century served specific social functions: documenting status, preserving likeness for family memory, and in some cases as diplomatic currency. Merchants and civic leaders were the primary patrons. The typical format — three-quarter view, hands folded or holding an object, plain dark or patterned background — became the standard European portrait formula."),
                    BookPage(title: "The Bruges Workshop System", content: "Van Eyck worked from a workshop in Bruges under the patronage of Duke Philip the Good of Burgundy. Workshop practice meant that multiple hands contributed to a single panel: the master executed key areas (faces, hands, expensive details) while trained assistants handled backgrounds, drapery, and ground preparation. Attribution to 'Van Eyck school' or 'Van Eyck workshop' is thus often more accurate than sole authorship.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Italian Renaissance Portraiture",
                author: "Lorne Campbell",
                coverColor: Color(red: 0.7, green: 0.2, blue: 0.2),
                synopsis: "Examines the development of portraiture in 15th and 16th century Italy, from Florentine profile views to Venetian psychological depth.",
                pages: [
                    BookPage(title: "The Italian Tradition", content: "Italian Renaissance portraiture developed largely independently of the Flemish tradition, though each influenced the other significantly. Early Italian portraits favoured strict profile views (derived from ancient coins), transitioning to three-quarter views after exposure to Flemish models. The Italian preference was for idealization and dignified abstraction rather than Flemish microscopic realism."),
                    BookPage(title: "Leonardo and the Psychological Portrait", content: "Leonardo da Vinci transformed portrait painting by introducing psychological depth and sfumato — the smoky atmospheric gradation that dissolves hard outlines. The Mona Lisa (1503–1519) is the supreme example: an ordinary sitter elevated to universal enigma through compositional mastery and the revolutionary sfumato technique.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "The History of Oak Panel Painting",
                author: "Peter Klein",
                coverColor: Color(red: 0.35, green: 0.25, blue: 0.15),
                synopsis: "A technical art-historical survey of panel painting supports in Northern Europe, with particular focus on dendrochronological dating methods.",
                pages: [
                    BookPage(title: "Oak as Support", content: "Northern European painters of the 15th–17th centuries overwhelmingly preferred oak panels as their primary support, in contrast to Italian painters who favoured poplar. Baltic oak, imported to Flanders via Hanseatic trade routes, was prized for its stability and fine grain. Individual panels were joined and prepared with multiple chalk and animal-glue ground layers before painting."),
                    BookPage(title: "Dendrochronology in Authentication", content: "Tree-ring dating (dendrochronology) provides the most reliable terminus post quem for panel paintings — the earliest possible date the painting could have been made. By comparing ring patterns against established regional chronologies, scientists can date the felling of the tree to within a few years. This dates the support, not the paint itself, but establishes a definitive earliest possible date.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Prof. Anne van der Meer",
            title: "Professor of Early Netherlandish Painting",
            institution: "Rijksmuseum Research Institute, Amsterdam",
            specialty: "15th-century Flemish portrait attribution",
            opinion: "The craftsmanship here is extraordinary — I've rarely seen this level of material detail in an unattributed work. The treatment of the skin, the way light accumulates in the transparent oil glazes... this is genuine 15th-century Flemish work at a very high level. I'd associate this with the Bruges school, specifically in the orbit of the great workshop active in the 1430s–1440s. I stop short of naming a specific hand, but this is major.",
            caveat: "Attribution within the Bruges school at this level requires comparison with every authenticated panel in the corpus. I'd want six months and direct examination. But 'Flemish, 15th century, Bruges school' — I'm certain of that.",
            cost: 1800
        ),
        auctionRecord: "Early Netherlandish panel portraits (Bruges school, c.1420–1460, authenticated) have sold: Christie's London 2018, £8.2M; Sotheby's New York 2020, $12.4M. A documented workshop attribution would still command $1M–$5M depending on condition and subject. Current work would require full scholarly authentication before major auction.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Jan van Eyck school, Bruges, c. 1430–1445",
            fullAnswer: "This is an early Netherlandish panel painting from the Jan van Eyck school (Bruges workshop), circa 1430–1445. The dendrochronological dating of the oak panel (wood felled c.1410–1430), the precise metalpoint underdrawing, the oil glazing technique with lapis lazuli ultramarine, and the extraordinary level of microscopic detail all confirm this attribution to the most significant workshop in 15th-century Northern Europe.",
            educationalExplanation: "Jan van Eyck (c.1390–1441) transformed Western painting by perfecting oil glazing — building up multiple transparent colour layers over a reflective white ground. This allowed unprecedented luminosity and the ability to render microscopic detail: individual hairs, textile weaves, reflected light in eyes. His portraits for Bruges merchants became the template for European portraiture for the next two centuries. The Arnolfini Portrait (1434, National Gallery, London) is his most celebrated surviving work."
        ),
        choices: ["Italian Renaissance (Florence, c.1480)", "Jan van Eyck school, Bruges, c. 1430–1445", "German Renaissance (Dürer school, c.1510)", "Spanish Golden Age (Velázquez era, c.1640)"],
        correctChoiceIndex: 1,
        successPayout: 12000,
        failurePenalty: 5000,
        baseXP: 200
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 5 ★★★☆☆  "Light from Darkness"
    // Goal: Identify the Period / Movement   Difficulty: Adept
    // ───────────────────────────────────────────────────────────────
    static let level5 = AppraisalCase(
        id: 5, levelNumber: 5,
        title: "Light from Darkness",
        difficulty: .adept,
        goal: .identifyPeriod,
        startingBudget: 12000,
        clientName: "Rosaria Ferretti",
        clientOccupation: "Museum Acquisitions Officer, Rome",
        clientStory: "We are considering this work for our permanent collection as an 'attributed Baroque' canvas. Before we commit the budget, I need independent confirmation of the period and movement. If it's genuinely 17th-century Italian Baroque in the Caravaggist tradition, we proceed. If not, we walk away. Simple as that.",
        artwork: ArtworkInfo(
            claimedTitle: "The Card Players (attributed)",
            claimedArtist: "Attributed to the Caravaggist School",
            claimedDate: "c. 1610–1630",
            medium: "Oil on canvas",
            dimensions: "130 × 98 cm",
            primaryColor: Color(red: 0.45, green: 0.30, blue: 0.15),
            accentColor: Color(red: 0.92, green: 0.82, blue: 0.55),
            darkColor: Color(red: 0.05, green: 0.03, blue: 0.01),
            artStyle: .dramaticScene
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Dramatic diagonal light; naturalistic faces from life",
                detail: "The light source — positioned high and to the left — creates a dramatic diagonal shaft that illuminates selected areas with almost theatrical intensity while the rest of the canvas recedes into near-total darkness. The faces appear drawn from specific living models rather than idealised types, a signature Caravaggist practice that scandalised contemporary audiences accustomed to idealized saints.",
                overlayStyle: .magnified
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Pigments consistent with early 17th century Italy",
                detail: "Lead white, red ochre, yellow ochre, bone black, vermilion, smalt (cobalt glass blue). No synthetic pigments. The lead white and smalt combination is characteristic of Roman and Neapolitan workshops of the 1600s–1620s. Smalt was the dominant blue pigment in Italian painting before ultramarine became more accessible. Dating: 1590–1650 range.",
                overlayStyle: .chemicalMapped
            ),
            .xRay: ToolFinding(
                tool: .xRay,
                headline: "Direct painting method; minimal underdrawing",
                detail: "X-radiography shows surprisingly minimal underdrawing — the composition was established largely in wet paint, with major adjustments made by painting over previous applications. This 'direct painting' method (alla prima) was characteristic of Caravaggio himself and his followers, who often worked rapidly from posed models without elaborate preparatory studies.",
                overlayStyle: .xrayRevealed
            ),
            .canvasDating: ToolFinding(
                tool: .canvasDating,
                headline: "Canvas weave and ground consistent with Roman practice c. 1600–1640",
                detail: "The canvas is coarse-weave linen, consistent with Italian painting practice of the early 17th century. The ground layer is a mid-toned red-brown priming (imprimatura) — characteristic of Caravaggio's method and later adopted by his followers as it provided a warm undervalue from which to build chiaroscuro. Dating consistent with 1600–1650.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Caravaggio: Light and Darkness",
                author: "Howard Hibbard",
                coverColor: Color(red: 0.15, green: 0.10, blue: 0.05),
                synopsis: "The definitive English-language study of Michelangelo Merisi da Caravaggio, examining his revolutionary naturalism, dramatic chiaroscuro, and scandalous subjects.",
                pages: [
                    BookPage(title: "Chiaroscuro and Tenebrism", content: "Caravaggio (1571–1610) developed an extreme form of chiaroscuro — the contrast of light and dark — called tenebrism. In tenebrism, figures emerge from near-total darkness into a concentrated shaft of light, with no intermediate half-tones. This technique was derived partly from his observation of actual candlelight and partly from a deliberate aesthetic philosophy: that truth is harsh, sudden, and partial."),
                    BookPage(title: "Naturalism and Scandal", content: "Caravaggio shocked his contemporaries by painting religious subjects using real, imperfect models — street people, peasants, prostitutes. His saints have dirty feet. His Madonnas are recognizable Roman women. This deliberate naturalism was a Counter-Reformation strategy (making the sacred immediate and accessible) but also a provocation that cost him several major commissions."),
                    BookPage(title: "The Caravaggist Network", content: "Caravaggio's revolutionary technique spread rapidly. His followers — the Caravaggists — include Artemisia Gentileschi, Jusepe de Ribera, Gerrit van Honthorst (the 'Candlelight Master'), Georges de La Tour, and many others across Europe. They adopted his chiaroscuro and naturalism while modifying his subjects according to their own markets and religious climates.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Sacred and Profane: Counter-Reformation Art",
                author: "Marcia Hall",
                coverColor: Color(red: 0.6, green: 0.15, blue: 0.15),
                synopsis: "Examines how the Catholic Church's Counter-Reformation shaped the visual arts in 17th-century Europe, directing artists toward accessible, emotionally compelling religious imagery.",
                pages: [
                    BookPage(title: "The Council of Trent's Art Decree", content: "The Council of Trent (1545–1563) established new guidelines for religious art: clarity, accuracy, and emotional impact over decorative excess. Images should move the faithful to devotion, not admire the artist's virtuosity. This directive paradoxically opened the door for Caravaggio's raw naturalism — his filthy-footed saints were maximally effective in moving ordinary viewers."),
                    BookPage(title: "Genre vs Sacred", content: "The Baroque period saw the flourishing of genre painting — scenes of everyday life — alongside religious commissions. Card players, musicians, fortune tellers: subjects Caravaggio introduced into Italian high art were taken up by his followers as independent genre subjects, no longer needing religious framing to find wealthy buyers.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Renaissance Masters: Florence and Rome",
                author: "Frederick Hartt",
                coverColor: Color(red: 0.5, green: 0.35, blue: 0.20),
                synopsis: "A survey of the Italian High Renaissance from Botticelli through Michelangelo and Raphael, covering the artistic flowering of the 15th and early 16th centuries.",
                pages: [
                    BookPage(title: "The High Renaissance Ideal", content: "The High Renaissance (c.1490–1527) sought ideal beauty — figures of perfect proportion, expressions of noble calm, compositions of mathematical clarity. Leonardo's sfumato, Raphael's harmonious grace, Michelangelo's heroic muscularity: each is a different expression of the same underlying ideal that human beings, at their best, approximate divine perfection."),
                    BookPage(title: "Mannerism as Reaction", content: "Mannerism (c.1520–1600) arose as a self-conscious reaction against the serenity of the High Renaissance, introducing elongation, artifice, complex poses, and acidic colour. It prepared the ground for the Baroque reaction that followed — where Caravaggio rejected both Renaissance idealism and Mannerist artifice in favour of raw observation.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. Gianluca Russo",
            title: "Professor of Baroque Studies",
            institution: "Accademia di Belle Arti di Roma",
            specialty: "Caravaggism and 17th-century Italian naturalism",
            opinion: "This is Baroque — without question. The tenebrism is the signature: that shaft of light from the upper left, the figures emerging from absolute darkness. And those faces — they're working people. A Mannerist or Renaissance painter would never have put those faces on a canvas. The card-playing subject also confirms it — Caravaggio introduced this kind of secular genre subject to Italian high art around 1594. This work follows his example.",
            caveat: "Attribution to a specific artist within the Caravaggist circle would require much more comparative analysis. There were dozens of competent followers across Rome, Naples, Milan, and beyond.",
            cost: 1500
        ),
        auctionRecord: "Attributed Caravaggist paintings (Rome/Naples, c.1610–1640, genre subjects, documented provenance) have sold: Sotheby's Milan 2023, €1.8M; Christie's London 2021, £2.4M. Attribution to a named Caravaggist artist could multiply value significantly.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Italian Baroque — Caravaggist School",
            fullAnswer: "This work is Italian Baroque, specifically in the Caravaggist tradition, circa 1610–1630. The extreme tenebrism (deep shadow with directed artificial light), the direct alla prima painting technique over a warm imprimatura ground, the naturalistic working-class models, and the secular card-playing subject all place this squarely in the school that Caravaggio founded and his followers across Italy perpetuated.",
            educationalExplanation: "The Baroque period (c.1600–1750) was in part a response to the Protestant Reformation and the Catholic Counter-Reformation, which called for accessible, emotionally powerful religious imagery. Caravaggio's answer was radical naturalism combined with dramatic chiaroscuro — making the sacred visceral and immediate. His influence spread across Europe: Artemisia Gentileschi in Rome and Naples, Ribera in Spain, Rubens incorporating his influence in Flanders, Rembrandt developing his own chiaroscuro in the Dutch Republic."
        ),
        choices: ["Italian High Renaissance (Raphael school, c.1510)", "Dutch Golden Age (Rembrandt school, c.1650)", "Italian Baroque — Caravaggist School (c.1610–1630)", "French Neoclassicism (c.1780)"],
        correctChoiceIndex: 2,
        successPayout: 10000,
        failurePenalty: 4000,
        baseXP: 200
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 6 ★★★☆☆  "Woman at the Window"
    // Goal: Full Attribution   Difficulty: Adept
    // ───────────────────────────────────────────────────────────────
    static let level6 = AppraisalCase(
        id: 6, levelNumber: 6,
        title: "Woman at the Window",
        difficulty: .adept,
        goal: .fullAttribution,
        startingBudget: 16000,
        clientName: "Dr. Thomas Bauer",
        clientOccupation: "Private Foundation Director, Vienna",
        clientStory: "Our foundation acquired this work in 1989 from a private Swiss collection. We've always listed it as 'Dutch School, 17th century.' A visiting scholar last month suggested it might be far more specific than that — possibly by the master of Delft himself. I need a definitive assessment before we lend this to an upcoming exhibition.",
        artwork: ArtworkInfo(
            claimedTitle: "Woman Reading a Letter (attributed Dutch School)",
            claimedArtist: "Dutch School, 17th century",
            claimedDate: "c. 1660–1670",
            medium: "Oil on canvas",
            dimensions: "44 × 38 cm",
            primaryColor: Color(red: 0.82, green: 0.72, blue: 0.52),
            accentColor: Color(red: 0.27, green: 0.51, blue: 0.71),
            darkColor: Color(red: 0.12, green: 0.09, blue: 0.06),
            artStyle: .interiorScene
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Extraordinary treatment of diffused window light",
                detail: "The light entering from the left window dissolves the edges of objects — walls, furniture, the woman's cap — in a way that is physically precise. This is not theatrical light (like Caravaggio) but observed natural light recorded with scientific attention. The pearl earring, if present, the texture of the map on the wall — the detail is perfect but never aggressive. This is domestic contemplation elevated to the universal.",
                overlayStyle: .magnified
            ),
            .uvLight: ToolFinding(
                tool: .uvLight,
                headline: "Old restoration in lower-left; original varnish largely intact",
                detail: "UV examination reveals a small area of restoration in the lower-left corner (floor area) — consistent with 18th or 19th century touch-up, not unusual for a work of this age. The majority of the surface shows the even, matte fluorescence of aged natural resin varnish, suggesting the work has been well-preserved. The original paint surface is largely intact.",
                overlayStyle: .uvRevealed
            ),
            .xRay: ToolFinding(
                tool: .xRay,
                headline: "Pentimento: a chair removed from original composition",
                detail: "X-radiography reveals a significant pentimento (compositional change): the artist originally included a chair in the right foreground, then painted it out. This alteration is documented in several authenticated works by the Delft master — his compositional process involved refinement toward simplicity, removing elements that competed with the psychological focus on the figure.",
                overlayStyle: .xrayRevealed
            ),
            .infrared: ToolFinding(
                tool: .infrared,
                headline: "Chalk underdrawing consistent with Delft workshop practice",
                detail: "Infrared reveals a careful chalk underdrawing for the figure and window — but notably less drawing for the spatial elements (floor tiles, furniture), which appear to have been established in thin paint directly. This combination of prepared figure drawing with freely painted environment is a documented technical characteristic of the Delft master's mature period.",
                overlayStyle: .infraredRevealed
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "Swiss provenance traces to pre-war Dutch collection",
                detail: "The Swiss collection acquired this work in 1946 from a Dutch private collector whose family documented holding it since 'the Napoleonic era.' No earlier written documentation survives, which is typical for Dutch domestic paintings that circulated in private hands without passing through major collections or auction houses. The provenance is not suspicious but not exceptional.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Vermeer: Master of Light",
                author: "John Michael Montias",
                coverColor: Color(red: 0.25, green: 0.42, blue: 0.65),
                synopsis: "The scholarly biography of Johannes Vermeer and the definitive study of his small but extraordinarily significant body of work — approximately 34–36 authenticated paintings.",
                pages: [
                    BookPage(title: "The Delft Interior", content: "Vermeer (1632–1675) painted almost exclusively domestic interior scenes — women reading letters, making lace, playing musical instruments, receiving visitors. These small paintings (rarely larger than 50×45cm) represent a profound meditation on privacy, attention, and the quality of light in a Dutch middle-class home. The camera obscura may have assisted his extraordinary spatial precision."),
                    BookPage(title: "Light as Subject", content: "In Vermeer's interiors, natural window light is not merely illumination — it is the true subject. Light entering from the left (always from the left) falls on figures and objects with a physical accuracy that was unprecedented. Modern analysis suggests Vermeer may have used a camera obscura to project scenes directly onto canvas, then traced the projected image with extraordinary sensitivity."),
                    BookPage(title: "The Compositional Process", content: "X-ray examination of multiple Vermeer paintings reveals a consistent pattern of pentimenti — compositional refinements toward greater simplicity. He frequently painted out chairs, cups, extra figures — anything that diluted the psychological focus on the main subject. The fewer the elements, the more profound the remaining ones become.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Dutch Genre Painting 1620–1700",
                author: "Wayne Franits",
                coverColor: Color(red: 0.55, green: 0.40, blue: 0.20),
                synopsis: "A comprehensive survey of domestic genre painting in the Dutch Republic, examining the market, iconography, and social meaning of scenes of everyday life.",
                pages: [
                    BookPage(title: "The Market for Genre", content: "17th-century Dutch genre painting emerged from a unique economic situation: an unprecedented middle-class art market of merchants, professionals, and civic leaders who wanted paintings for their homes rather than churches. The result was an explosion of subject matter: taverns, kitchens, music-making, letter-writing — ordinary life rendered extraordinary."),
                    BookPage(title: "Hidden Meanings", content: "Dutch genre paintings often encode moral messages that modern viewers miss. Letters frequently signify illicit love (letter-reading women may be receiving from secret admirers). Musical instruments suggest harmony — or its opposite. Maps on walls indicate wealth, travel, and global commerce. What looks like a simple domestic scene may be laden with symbolic intent.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "The Camera Obscura and Early Modern Painting",
                author: "Philip Steadman",
                coverColor: Color(red: 0.4, green: 0.4, blue: 0.4),
                synopsis: "An investigation into the use of optical devices in 17th-century painting, with particular focus on Vermeer's possible use of the camera obscura.",
                pages: [
                    BookPage(title: "What is a Camera Obscura?", content: "A camera obscura (Latin: 'dark room') is an optical device in which light from outside passes through a small hole or lens into a darkened space, projecting an inverted image of the outside world onto a surface inside. Artists could use this projected image as a guide for drawing, achieving spatial accuracy and correct perspective with optical precision."),
                    BookPage(title: "The Vermeer Hypothesis", content: "Art historian Philip Steadman argued that the spatial geometry of Vermeer's interiors is consistent with projection from a camera obscura positioned in specific locations in the room being depicted. The same room — identifiable by specific features — appears in multiple Vermeer paintings from different angles, consistent with a fixed studio setup.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. Claire Van Doorn",
            title: "Head of Dutch and Flemish Studies",
            institution: "Mauritshuis, The Hague",
            specialty: "Vermeer and the Delft School",
            opinion: "The treatment of light here is extraordinary — and I use that word carefully. The way the window light dissolves the cap edge, the quality of attention on the figure... this is not generic Dutch School. This is someone who understood light the way almost no one else in the 17th century did. I'm going to say Vermeer, but I hold that opinion with appropriate humility. We know so little about his studio and workshop.",
            caveat: "I'd want to compare this directly against the authenticated corpus — particularly the Woman Reading a Letter in Amsterdam and The Love Letter. The pentimento evidence is very significant if it matches Vermeer's known pattern.",
            cost: 2000
        ),
        auctionRecord: "Johannes Vermeer (authenticated): Only 34–36 paintings known, almost all in major museum collections. The last to reach auction (Young Woman Seated at a Virginal) sold for $30.1M at Sotheby's London in 2004. Any new authenticated Vermeer would be among the most significant art market events in history. Attribution contested works at 'Vermeer School' level: $500,000–$5M.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Johannes Vermeer, Delft, c. 1662–1665",
            fullAnswer: "This painting is by Johannes Vermeer, executed in Delft circa 1662–1665. The technically flawless treatment of diffused window light, the pentimento consistent with Vermeer's documented compositional process, the chalk underdrawing technique, and the period-appropriate materials all confirm attribution to the Delft master.",
            educationalExplanation: "Johannes Vermeer (1632–1675) is considered one of the supreme masters of Western painting, yet only 34–36 authenticated works survive. He worked slowly, produced little, and died in debt. His extraordinary domestic interiors — almost always featuring women in private moments of reading, music, or contemplation — represent an unprecedented quality of optical attention. The camera obscura may have helped his spatial precision, but the emotional intelligence of his compositions was entirely his own."
        ),
        choices: ["Pieter de Hooch (Dutch Genre, c.1660)", "Johannes Vermeer, Delft, c. 1662–1665", "Gabriel Metsu (Dutch Genre, c.1665)", "Jan Steen (Dutch Genre, c.1670)"],
        correctChoiceIndex: 1,
        successPayout: 14000,
        failurePenalty: 6000,
        baseXP: 250
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 7 ★★★★☆  "The Harvest"
    // Goal: Identify Movement & Decade   Difficulty: Expert
    // ───────────────────────────────────────────────────────────────
    static let level7 = AppraisalCase(
        id: 7, levelNumber: 7,
        title: "The Harvest",
        difficulty: .expert,
        goal: .identifyPeriod,
        startingBudget: 14000,
        clientName: "George Whitfield",
        clientOccupation: "Midwestern Farming Cooperative, Illinois",
        clientStory: "We found this canvas in the basement of our co-op's original 1940s building. It was clearly painted for the building — it's the right scale, the subject matter fits, and there are what look like government stamps on the stretcher bar. We need to know what we have before we decide what to do with it.",
        artwork: ArtworkInfo(
            claimedTitle: "The Harvest (unattributed mural study)",
            claimedArtist: "Unknown American Artist",
            claimedDate: "Unknown",
            medium: "Oil on canvas",
            dimensions: "122 × 183 cm",
            primaryColor: Color(red: 0.75, green: 0.55, blue: 0.25),
            accentColor: Color(red: 0.25, green: 0.50, blue: 0.70),
            darkColor: Color(red: 0.20, green: 0.12, blue: 0.04),
            artStyle: .ruralLandscape
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Bold, simplified forms; monumental figures of laborers",
                detail: "The figures — farmers, families, a tractor in the middle distance — are rendered in simplified, monumental forms with crisp outlines and clear colour areas. There is no Impressionist flickering or atmospheric dissolution; this is solid, deliberate, socially conscious art. The faces are idealized but grounded — not heroic propaganda, but dignified ordinary people.",
                overlayStyle: .magnified
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "WPA stamp on stretcher bar — Treasury Relief Art Project, 1937",
                detail: "The stretcher bar stamp reads: 'TRAP — Treasury Relief Art Project, Illinois District, Project #IL-44, 1937.' The Treasury Relief Art Project was a New Deal program under the Farm Security Administration that employed artists during the Great Depression to create works for public buildings. This is a documented government-commissioned American Regionalist work.",
                overlayStyle: .documentView
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Alkyd-modified oil paint; titanium white — consistent with late 1930s",
                detail: "Analysis reveals titanium white (commercially available from 1921 onward) blended with zinc white, and early alkyd-modified oil paints that became common in the mid-1930s. No anachronistic materials. The pigment suite — cadmium yellow, Prussian blue, titanium white, burnt sienna — is entirely consistent with American commercial paint production of the 1930s.",
                overlayStyle: .chemicalMapped
            ),
            .infrared: ToolFinding(
                tool: .infrared,
                headline: "Detailed preparatory drawing; squared-up grid visible",
                detail: "Infrared reveals a highly detailed preliminary drawing with a squared-up grid — evidence that the composition was transferred from a smaller preparatory study using the traditional grid-transfer method. This is consistent with mural-scale works of the WPA/TRAP era, where artists prepared detailed cartoons before scaling up to large canvases or walls.",
                overlayStyle: .infraredRevealed
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "American Regionalism: Grant Wood, Thomas Hart Benton, John Steuart Curry",
                author: "Erika Lee Doss",
                coverColor: Color(red: 0.70, green: 0.45, blue: 0.15),
                synopsis: "The definitive study of American Regionalism — the 1930s movement that celebrated rural American life and rejected European modernism in favour of accessible, socially engaged figurative art.",
                pages: [
                    BookPage(title: "What Was American Regionalism?", content: "American Regionalism was a figurative art movement of the 1930s, centred on three painters: Grant Wood (Iowa), Thomas Hart Benton (Missouri), and John Steuart Curry (Kansas). Reacting against European abstraction, they painted the American heartland — farmers, small towns, rural landscapes — in a bold, simplified style that made their work immediately accessible to ordinary Americans. Wood's 'American Gothic' (1930) is the movement's defining image."),
                    BookPage(title: "The New Deal Arts Programs", content: "The Great Depression created an unprecedented government role in the arts. The Works Progress Administration (WPA), Treasury Section, and Treasury Relief Art Project (TRAP) employed thousands of artists between 1935 and 1943, commissioning murals, paintings, and sculptures for public buildings: post offices, schools, courthouses, and government offices. These programs supported artists while bringing art to communities that had never had access to it."),
                    BookPage(title: "Style and Ideology", content: "Regionalist painting valued clarity, narrative legibility, and democratic accessibility over formal experimentation. Colours are clean and unambiguous. Forms are simplified but not abstract. Subjects are labourers, farmers, families — the American working people whom the movement sought to celebrate and dignify. The style draws on Renaissance fresco traditions (monumental figures, clear spatial organisation) and the Mexican Muralism of Rivera, Orozco, and Siqueiros.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "The Ashcan School: Urban Realism in Early America",
                author: "Rebecca Zurier",
                coverColor: Color(red: 0.3, green: 0.3, blue: 0.5),
                synopsis: "Examines the Ashcan School — America's first major urban realist movement — which painted the unglamorous realities of city life in the 1900s–1920s.",
                pages: [
                    BookPage(title: "The Eight", content: "The Ashcan School coalesced around 'The Eight,' a group who exhibited together in 1908 in protest against the National Academy of Design's conservatism. Robert Henri, John Sloan, George Luks, and others painted New York's tenements, bars, and back alleys with a vigorous, journalistic directness that shocked audiences expecting prettified genre scenes."),
                    BookPage(title: "Urban vs Rural", content: "The Ashcan School's focus on the city contrasts sharply with the later Regionalists' celebration of rural America. Both movements were forms of social realism — committed to depicting ordinary working people honestly — but they reflected very different Americas: the immigrant urban poor vs the farming heartland.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Abstract Expressionism: The New York School",
                author: "David Anfam",
                coverColor: Color(red: 0.15, green: 0.15, blue: 0.40),
                synopsis: "Surveys the Abstract Expressionist movement that emerged from New York in the 1940s–50s, establishing American art as the dominant global force in the post-war era.",
                pages: [
                    BookPage(title: "After the War", content: "Abstract Expressionism emerged as American artists — many of them immigrants or children of immigrants — reacted to the trauma of World War II and the Holocaust. The movement's emotional intensity, vast scale, and rejection of representation reflected a sense that traditional subject matter was inadequate to the magnitude of what had occurred."),
                    BookPage(title: "Pollock and Action Painting", content: "Jackson Pollock's drip paintings of 1947–1950 represent the most radical break in American art history: the abandonment of the brush, the easel, and the upright canvas in favour of pouring, flinging, and dripping paint onto canvas laid flat on the floor. The gesture — the physical act of the artist's body — became the subject.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. Patricia Gomez",
            title: "Curator of American Art",
            institution: "Smithsonian American Art Museum, Washington D.C.",
            specialty: "New Deal art programs and American Regionalism",
            opinion: "That government stamp is remarkable — TRAP works are well-documented and increasingly valued. The style is clearly Regionalist: simplified monumental figures, clear colour organization, rural subject matter. This isn't Grant Wood — the handling is looser — but it's entirely within the Regionalist idiom. The grid-transfer technique confirms this was a serious commissioned work, not an amateur effort. 1935–1940 is my confident range.",
            caveat: "TRAP documentation is archived at the National Archives. If you can match the project number to a specific artist's contract, you might be able to name the painter.",
            cost: 1600
        ),
        auctionRecord: "WPA/TRAP works (documented government commission, American Regionalist subject, 1930s): Swann Auction Galleries 2022, $85,000–$180,000 range. Attribution to a named Regionalist artist would significantly increase value. Grant Wood: $1M+. Thomas Hart Benton: $500K–$2M.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "American Regionalism, 1930s (WPA-era, 1937)",
            fullAnswer: "This is an American Regionalist painting, c.1937, commissioned under the Treasury Relief Art Project (TRAP). The WPA stamp confirms the date and government sponsorship. The simplified monumental rural figures, clear palette, and bold compositional organisation are hallmarks of the Regionalist movement of the 1930s, which celebrated rural American life in response to the Great Depression.",
            educationalExplanation: "American Regionalism (c.1930–1945) was a deliberate rejection of European modernism — Grant Wood famously disparaged artists who went to Paris to learn to paint abstractly. Instead, Regionalists painted the American Midwest and South in a bold, accessible figurative style derived partly from Renaissance fresco and Mexican Muralism. The New Deal arts programs employed thousands of artists during the Depression, creating the largest government arts patronage in American history and leaving a rich legacy in public buildings across the country."
        ),
        choices: ["Ashcan School (c.1908–1915)", "American Regionalism, WPA-era (c.1935–1940)", "Abstract Expressionism (c.1948–1955)", "Social Realism, post-war (c.1950–1960)"],
        correctChoiceIndex: 1,
        successPayout: 11000,
        failurePenalty: 5000,
        baseXP: 280
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 8 ★★★★☆  "The Chemical Lie"
    // Goal: Real or Fake?   Difficulty: Expert
    // ───────────────────────────────────────────────────────────────
    static let level8 = AppraisalCase(
        id: 8, levelNumber: 8,
        title: "The Chemical Lie",
        difficulty: .expert,
        goal: .authenticateRealOrFake,
        startingBudget: 16000,
        clientName: "Armand Delacourt",
        clientOccupation: "Insurance Underwriter, Paris",
        clientStory: "My client is seeking $8 million in coverage for this Modigliani portrait, which they claim was purchased privately from a Roman collector in 1971 with full documentation. The stylistic quality is convincing — even several gallery directors we consulted were impressed. But I need technical certainty before we write this policy. One of our previous clients lost everything on a 'perfect' Modigliani that turned out to be a perfect fake.",
        artwork: ArtworkInfo(
            claimedTitle: "Portrait de Femme",
            claimedArtist: "Amedeo Modigliani",
            claimedDate: "c. 1913",
            medium: "Oil on canvas",
            dimensions: "73 × 60 cm",
            primaryColor: Color(red: 0.88, green: 0.72, blue: 0.52),
            accentColor: Color(red: 0.42, green: 0.35, blue: 0.58),
            darkColor: Color(red: 0.08, green: 0.06, blue: 0.04),
            artStyle: .portraitBust
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Stylistically convincing — elongated neck, almond eyes, tilted head",
                detail: "The visual characteristics match Modigliani's documented style: the swan-like elongated neck, the almond-shaped eyes with no pupils (a deliberate choice — Modigliani said he would paint eyes when he knew the soul), the slight tilt of the head, the simplified sculptural face influenced by African masks and Cézanne. To the eye, this is excellent. Style alone is insufficient for authentication.",
                overlayStyle: .magnified
            ),
            .uvLight: ToolFinding(
                tool: .uvLight,
                headline: "Varnish appears artificially aged — too uniform",
                detail: "UV examination shows a perfectly even varnish fluorescence, which is suspicious. Old varnish typically shows uneven fluorescence from differential aging, exposure, and past cleaning. This even fluorescence is consistent with a modern varnish artificially tinted or 'antiqued' to simulate age. This alone is not proof of forgery, but it is a flag.",
                overlayStyle: .uvRevealed
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "CRITICAL: Titanium white and synthetic organic pigments detected",
                detail: "This is conclusive. Analysis detects: (1) Titanium white — not commercially available until 1921, eight years after the claimed date of 1913. Modigliani died in 1920. He could never have used titanium white. (2) Phthalocyanine Blue — synthetic, not developed until 1935. (3) A synthetic organic red (Naphthol AS) not available until the 1950s. Three anachronistic pigments. This painting cannot have been made in 1913.",
                overlayStyle: .chemicalMapped
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "1971 Rome documentation cannot be verified",
                detail: "The 'private Roman collector' documentation consists of a typed letter and a receipt on non-verified stationery. No cross-referencing with Italian tax records, notarial documentation, or import/export permits that would have been required for an artwork of this value being moved across borders in 1971. The documentation appears to have been created to provide plausible provenance for a forged work.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "The Art of Authentication: Science and Connoisseurship",
                author: "Rika Burnham",
                coverColor: Color(red: 0.4, green: 0.15, blue: 0.40),
                synopsis: "The definitive practical guide to authenticating works of art, examining the interplay between visual connoisseurship, scientific analysis, and provenance research.",
                pages: [
                    BookPage(title: "Why Chemistry Matters", content: "A forger can study an artist's style for years and produce a visually convincing imitation. But chemistry cannot be faked. Every commercial pigment has a documented introduction date. Titanium white: 1921. Phthalocyanine Blue: 1935. Cadmium orange (modern formulation): 1907 but standardized industrially 1950s. Acrylic paint: 1950s. Any anachronistic pigment in a 'period' work is absolute proof of forgery — the period of production cannot predate the period of the pigment's availability."),
                    BookPage(title: "The Pigment Timeline", content: "Artists' pigments have specific introduction dates that create a firm timeline. Lead white: ancient. Prussian blue: 1704. Cobalt blue: 1802. Ultramarine (synthetic): 1828. Chrome yellow: 1809. Cadmium yellow: 1817. Viridian: 1838. Titanium white: 1921. Phthalocyanine (Phthalo) Blue: 1935. These dates are absolute. A painting claiming to predate a detected pigment is a forgery or misdated original."),
                    BookPage(title: "The Modigliani Forgery Problem", content: "Amedeo Modigliani (1884–1920) has become one of the most forged artists of the 20th century, second only to Van Gogh and Picasso. His distinctive style is deceptively learnable: the elongation, the simplified faces, the muted palette. A 2018 Genoa exhibition removed 21 of 24 exhibited 'Modiglianis' after they were identified as forgeries during installation — including works that had been in respected collections for decades.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Modigliani: Life and Work",
                author: "Noël Alexandre",
                coverColor: Color(red: 0.65, green: 0.35, blue: 0.15),
                synopsis: "A comprehensive biography and catalogue of Modigliani's paintings, sculpture, and drawings, tracing his short but intensely productive life.",
                pages: [
                    BookPage(title: "The Livorno Years", content: "Amedeo Modigliani (1884–1920) was born in Livorno, Italy, to a Sephardic Jewish family. He contracted tuberculosis as a teenager — the disease that would kill him at 35. He moved to Paris in 1906, settling in Montparnasse, and was immediately absorbed into the avant-garde circle: Picasso, Brancusi, Soutine, Apollinaire. His sculpture (influenced by African art and Brancusi) preceded his mature painted portraits."),
                    BookPage(title: "The Portrait Style", content: "Modigliani's mature portrait style (c.1915–1920) is immediately recognizable: elongated necks and faces derived from African masks and Cézanne's constructive method; the tilted head as psychological gesture; eyes often shown blank (without painted pupils) as a deliberate withholding of the soul; simplified colour areas with warm flesh tones against neutral backgrounds. He is said to have told a model: 'I will paint your eyes when I know your soul.'")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Italian Avant-Garde: Futurism and Beyond",
                author: "Günter Berghaus",
                coverColor: Color(red: 0.65, green: 0.55, blue: 0.10),
                synopsis: "Surveys the Italian Futurist movement and its contemporaries, examining the artistic scene in early 20th century Italy and Paris.",
                pages: [
                    BookPage(title: "Paris as Magnet", content: "In the early 20th century, Paris was the unquestioned world capital of modern art. The city attracted artists from across Europe and beyond — Picasso from Spain, Modigliani from Italy, Chagall from Russia, Brancusi from Romania. Montmartre and then Montparnasse became the geographical centres of an extraordinary concentration of artistic talent and ambition."),
                    BookPage(title: "The École de Paris", content: "The 'School of Paris' (École de Paris) is not a formal movement but a retrospective term for the cosmopolitan community of artists — many of them Jewish immigrants or exiles — who worked in Paris between roughly 1905 and 1940. Modigliani, Soutine, Chagall, Lipchitz: these artists shared a community and influenced each other without sharing a manifesto.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Dr. Emmanuelle Bossert",
            title: "Director, Scientific Research",
            institution: "Centre de Recherche et de Restauration des Musées de France (C2RMF)",
            specialty: "Technical analysis and authentication of early 20th-century works",
            opinion: "Stylistically, I understand why people are impressed. It's a good imitation of his manner. But I've examined dozens of Modigliani authentication requests and I always say the same thing: chemistry first, eyes second. I want to see what's in the paint before I form an opinion on the brushwork.",
            caveat: "If the chemistry comes back clean — period-appropriate pigments only — then we have a serious conversation. If there's titanium white or anything post-1920, the conversation is over.",
            cost: 2000
        ),
        auctionRecord: "Authenticated Modigliani portraits (1915–1919 period, documented provenance): Christie's London 2018, £28.4M; Sotheby's New York 2021, $41.6M. Forgeries with no claim to authenticity: worthless as art market assets, though the market for 'decorative Modigliani-style works' (openly sold as such) exists at $5,000–$50,000.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Forgery",
            fullAnswer: "This painting is a modern forgery. Three anachronistic pigments prove it cannot have been made in 1913: Titanium white (available from 1921), Phthalocyanine Blue (1935), and a synthetic Naphthol red (1950s). Modigliani died in 1920. No painting he made could contain materials invented after his death. The stylistic quality is high — this is a skilled forgery — but chemistry is absolute.",
            educationalExplanation: "Pigment chronology is one of the most powerful tools in art authentication. Every synthetic pigment has a documented commercial introduction date. A painting claiming to predate a detected pigment is either a forgery or grossly misdated. The Modigliani forgery market is enormous — his distinctive and learnable style has attracted forgers for decades. The 2018 Genoa exhibition scandal, in which 21 of 24 'Modiglianis' were removed as fakes, illustrates how even respected institutions and experienced experts can be deceived by visual style alone. Chemistry is the final arbiter."
        ),
        choices: ["Authentic Modigliani, c.1913", "Forgery", "Circle of Modigliani (contemporary follower)", "Authentic but misdated — c.1919"],
        correctChoiceIndex: 1,
        successPayout: 13000,
        failurePenalty: 6500,
        baseXP: 300
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 9 ★★★★☆  "Fields of Silence"
    // Goal: Full Attribution   Difficulty: Expert
    // ───────────────────────────────────────────────────────────────
    static let level9 = AppraisalCase(
        id: 9, levelNumber: 9,
        title: "Fields of Silence",
        difficulty: .expert,
        goal: .fullAttribution,
        startingBudget: 18000,
        clientName: "Dr. Miriam Gold",
        clientOccupation: "Trustee, Private Foundation",
        clientStory: "Our foundation's benefactor collected this large canvas in New York in the late 1950s. He said he bought it directly from a painter — a friend of his from the 10th Street scene. No receipt, no paperwork. He died last year and left the painting to the foundation with a note that said only: 'This is important. Find out who made it.' Can you?",
        artwork: ArtworkInfo(
            claimedTitle: "Untitled (Red and Black on Maroon)",
            claimedArtist: "Unknown (New York, c.1950s)",
            claimedDate: "c. 1956–1960",
            medium: "Oil and acrylic on canvas (large format)",
            dimensions: "265 × 381 cm",
            primaryColor: Color(red: 0.65, green: 0.08, blue: 0.08),
            accentColor: Color(red: 0.85, green: 0.20, blue: 0.05),
            darkColor: Color(red: 0.08, green: 0.03, blue: 0.03),
            artStyle: .abstractField
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Multiple thinned paint layers; edges deliberately soft",
                detail: "Close examination reveals the painting is built from multiple layers of thinned paint — the edges of the rectangular fields are deliberately soft, blurred, as if the colour fields breathe into one another rather than stop. This is not an accident of brushwork; it is a studied technique achieved by applying very thin translucent layers and working wet-into-wet at the boundaries. The scale engulfs the viewer.",
                overlayStyle: .magnified
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Rabbit-skin glue sizing; dry pigment and egg tempera underpainting",
                detail: "Analysis reveals a rabbit-skin glue canvas sizing, a dry pigment mixed with egg tempera underpainting layer, and successive oil paint layers. This specific preparatory technique — sizing, tempera underpainting, then oils — is a documented working method of one specific New York painter who was deeply concerned with the materiality of paint and its interaction with canvas. Acrylic media also detected in surface layers, placing this after 1950.",
                overlayStyle: .chemicalMapped
            ),
            .infrared: ToolFinding(
                tool: .infrared,
                headline: "No composition drawing — pure direct application",
                detail: "Infrared reveals no underdrawing whatsoever. The composition emerged entirely from the act of painting — large fields of colour applied and adjusted directly, with no preliminary planning on the canvas surface. This is consistent with the working method of the Color Field painters, who sought to discover composition through the painting process itself.",
                overlayStyle: .infraredRevealed
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "New York 10th Street scene, c.1956 — traces to Cedar Tavern circle",
                detail: "Research into the New York 10th Street artist community of the 1950s — centred on the Cedar Tavern in Greenwich Village, the 10th Street galleries, and the Artists' Club — reveals that the benefactor was documented as a collector patron associated with this circle. Cross-referencing with exhibition records from the Parsons Gallery (1954–1961) and the Jewish Museum (1961–1963) suggests this canvas may have been exhibited under an 'Untitled' designation in the late 1950s.",
                overlayStyle: .documentView
            ),
            .canvasDating: ToolFinding(
                tool: .canvasDating,
                headline: "Canvas consistent with 1950s New York commercial stock",
                detail: "The large-format canvas is a double-prime cotton duck — the standard material of New York Abstract Expressionists who required vast surfaces. The stretcher bars are kiln-dried white pine, consistent with American commercial stretcher stock of the 1950s. Dating is consistent with the claimed 1956–1960 range.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "Mark Rothko: Color and Transcendence",
                author: "James E.B. Breslin",
                coverColor: Color(red: 0.55, green: 0.10, blue: 0.10),
                synopsis: "The authoritative biography of Mark Rothko and the definitive study of his Color Field paintings — their technique, spiritual intentions, and legacy.",
                pages: [
                    BookPage(title: "The Color Field", content: "Mark Rothko (1903–1970), born Markus Yakovlevich Rothkowitz in Latvia, arrived in New York as a child immigrant. By the late 1940s, he had abandoned figurative painting entirely in favour of what he called 'basic human emotions — tragedy, ecstasy, doom.' His mature paintings consist of soft-edged rectangular fields of luminous colour that seem to float on the canvas surface, pulsing with internal light."),
                    BookPage(title: "Technique and Spirit", content: "Rothko's technique was elaborate despite the apparent simplicity. He sized his canvases with rabbit-skin glue (for the specific way it allowed paint to absorb differently), applied tempera underpaintings, then built successive layers of diluted oil paint. The edges of his colour fields were deliberately soft, painted wet-into-wet to create a sense of breathing or vibration. He wanted his paintings to be experienced as living presences."),
                    BookPage(title: "The Chapel and Late Work", content: "Rothko's late work darkened progressively. The Rothko Chapel in Houston (1971) — fourteen large-format paintings in near-black maroon, black, and plum — represents his most austere statement. He was found dead in his studio in 1970, having cut his wrists, shortly after completing the chapel works. His late paintings are among the most spiritually charged in 20th-century art.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Abstract Expressionism: The New York School",
                author: "David Anfam",
                coverColor: Color(red: 0.15, green: 0.15, blue: 0.45),
                synopsis: "A comprehensive survey of Abstract Expressionism — America's first internationally dominant art movement — from its origins in Surrealist exile to its triumph in the 1950s.",
                pages: [
                    BookPage(title: "Two Tendencies", content: "Abstract Expressionism encompassed two distinct tendencies: Action Painting (Pollock, de Kooning, Kline) — where the physical gesture of painting was primary, resulting in energetic, gestural surfaces; and Color Field (Rothko, Newman, Still) — where large, relatively calm expanses of colour were intended to create meditative, almost environmental experiences. Both rejected representation but pursued radically different aesthetics."),
                    BookPage(title: "Barnett Newman and the Zip", content: "Barnett Newman's contribution was the 'zip' — a thin vertical stripe of colour cutting through a monochrome field. Where Rothko's forms float and breathe, Newman's zips stand upright and active, suggesting the vertical human figure and the act of creation. 'Onement I' (1948) marks the beginning of his mature vision.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "The New York Art Market 1945–1970",
                author: "Judith Zilczer",
                coverColor: Color(red: 0.35, green: 0.35, blue: 0.35),
                synopsis: "Documents the rise of New York as the world's art market capital after WWII, tracing the galleries, collectors, and critics who transformed American art's international standing.",
                pages: [
                    BookPage(title: "Betty Parsons Gallery", content: "The Betty Parsons Gallery (established 1946) was the first and most important gallery for Abstract Expressionism, representing Pollock, Rothko, Newman, and Kline in their formative years. Parsons had an extraordinary instinct for quality but limited business acumen — she lost Pollock, Rothko, and others to dealers who offered better financial terms."),
                    BookPage(title: "The Cedar Tavern Circle", content: "The Cedar Street Tavern on University Place was the social centre of the New York art world from the early 1950s. Pollock drank there heavily; de Kooning held court; collectors, critics, and artists mixed in the sawdust-floored bar. Relationships formed there drove careers, commissions, and reputations for a generation.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Prof. David Geffen",
            title: "Professor of Post-War American Art",
            institution: "Yale School of Art and Art History",
            specialty: "Abstract Expressionism and Color Field painting",
            opinion: "The scale, the palette, the soft-edge technique — and specifically this dark maroon-red-black colour relationship — points clearly toward one artist. I see this configuration in the late 1950s work with extraordinary regularity. The spiritual weight of these colour relationships — it's not decoration. It's not expressive gesture. It's an attempt to make you feel something you have no name for. That's exactly the intention of one specific painter from this period.",
            caveat: "Attribution requires comparison against the authenticated catalogue and provenance documentation. But my confidence is high. The technical details you described — the rabbit-skin glue, the tempera underpainting — those aren't common knowledge. That's specialized procedure.",
            cost: 2200
        ),
        auctionRecord: "Mark Rothko (authenticated, late 1950s, large format): Sotheby's New York 2012, $86.9M ('Orange, Red, Yellow'); Christie's New York 2015, $56.2M. Even smaller authenticated works command $20M+. This scale and period (if authenticated) would be among the most significant works to come to market in recent years.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Mark Rothko, Color Field, c. 1956–1958",
            fullAnswer: "This painting is by Mark Rothko, executed circa 1956–1958, during his mature Color Field period. The specific technique (rabbit-skin glue sizing, tempera underpainting, layered thinned oils), the characteristic soft-edged rectangular fields, the dark maroon-red-black palette, the large format, and the New York 10th Street provenance all point conclusively to Rothko in his greatest period.",
            educationalExplanation: "Mark Rothko (1903–1970) was born Markus Rothkowitz in Latvia and immigrated to the United States as a child. His mature Color Field paintings — developed from the late 1940s onward — consist of soft-edged rectangular zones of luminous colour that he intended not as aesthetic objects but as emotional presences. He wanted viewers to weep before his paintings. 'If you are only moved by colour relationships, you are missing the point,' he said. His late work darkened toward the near-black canvases of the Rothko Chapel (Houston, 1971), completed shortly before his suicide in 1970."
        ),
        choices: ["Barnett Newman (Color Field, c.1955)", "Mark Rothko, Color Field, c. 1956–1958", "Clyfford Still (Abstract Expressionism, c.1958)", "Franz Kline (Action Painting, c.1957)"],
        correctChoiceIndex: 1,
        successPayout: 15000,
        failurePenalty: 7000,
        baseXP: 350
    )

    // ───────────────────────────────────────────────────────────────
    // LEVEL 10 ★★★★★  "The Rembrandt Question"
    // Goal: Assess Authenticity & Condition   Difficulty: Grand Master
    // ───────────────────────────────────────────────────────────────
    static let level10 = AppraisalCase(
        id: 10, levelNumber: 10,
        title: "The Rembrandt Question",
        difficulty: .grandmaster,
        goal: .assessCondition,
        startingBudget: 25000,
        clientName: "Interpol Art Crime Division",
        clientOccupation: "Art Crime Investigation",
        clientStory: "This work was seized from a Swiss freeport storage facility in connection with an ongoing money-laundering investigation. It is claimed to be an authenticated Rembrandt self-portrait with a suspect provenance chain. We need a complete technical assessment: is any part of this painting authentic, and what exactly are we looking at? Your report will be used in criminal proceedings.",
        artwork: ArtworkInfo(
            claimedTitle: "Self-Portrait (claimed Rembrandt)",
            claimedArtist: "Rembrandt Harmenszoon van Rijn",
            claimedDate: "c. 1658–1662",
            medium: "Oil on canvas",
            dimensions: "114 × 94 cm",
            primaryColor: Color(red: 0.30, green: 0.20, blue: 0.10),
            accentColor: Color(red: 0.80, green: 0.65, blue: 0.35),
            darkColor: Color(red: 0.06, green: 0.04, blue: 0.02),
            artStyle: .portraitBust
        ),
        toolFindings: [
            .magnifyingGlass: ToolFinding(
                tool: .magnifyingGlass,
                headline: "Surface quality exceptional — but two distinct paint layers visible",
                detail: "Close examination reveals a subtle but clear tonal inconsistency across the face: the impasto buildup in the forehead and eyes appears to sit on top of a slightly different paint layer visible at the edges of the composition. The background and clothing areas show the luminous brown tonality of genuine aged oil paint. The face — specifically the central facial features — has a slightly different surface tension, as if applied later.",
                overlayStyle: .magnified
            ),
            .uvLight: ToolFinding(
                tool: .uvLight,
                headline: "CRITICAL: Facial features fluoresce differently — recent overpainting confirmed",
                detail: "UV fluorescence is dramatically uneven. The majority of the canvas — background, clothing, hair — shows the matte, uneven fluorescence of genuine 17th-century paint aged 350+ years. But the central face — specifically the eyes, nose, and mouth — shows the bright, even fluorescence of recent (post-1950) paint application. Someone repainted the face. The rest of the canvas may be genuinely old.",
                overlayStyle: .uvRevealed
            ),
            .xRay: ToolFinding(
                tool: .xRay,
                headline: "Original composition was a LANDSCAPE — self-portrait painted over",
                detail: "X-radiography reveals the original composition beneath the self-portrait: a pastoral landscape with trees and a distant sky. The stretcher and canvas are 17th century (consistent with Dutch practice). But the original painting was a landscape, not a portrait. The self-portrait — likely beginning with a genuine old face area — was systematically overpainted in the mid-20th century to create a fake Rembrandt self-portrait on an authentic old canvas.",
                overlayStyle: .xrayRevealed
            ),
            .chemicalAnalysis: ToolFinding(
                tool: .chemicalAnalysis,
                headline: "Mixed-period pigments confirm composite fraud",
                detail: "Results confirm the composite nature: Background and clothing show period-appropriate 17th-century Dutch pigments (lead white, natural ultramarine, bone black, smalt, earth tones). The facial features show: titanium white (post-1921) and Phthalocyanine Blue in the highlight areas. The fraud involved painting over an authentic 17th-century landscape canvas — possibly Dutch, possibly Flemish — with new self-portrait elements using modern materials.",
                overlayStyle: .chemicalMapped
            ),
            .canvasDating: ToolFinding(
                tool: .canvasDating,
                headline: "Canvas: authentic 17th century. Paint: partially modern.",
                detail: "The canvas support is authentic 17th-century linen with characteristic hand-loomed weave structure. Fiber dating is consistent with pre-1700 Dutch linen production. The ground layer is an authentic 17th-century chalk and lead white preparation. The old paint layers (landscape) are genuinely historical. The self-portrait elements painted over them are modern. This confirms deliberate fraud: using authentic 17th-century material to give a forged composition the surface of age.",
                overlayStyle: .documentView
            ),
            .provenanceSearch: ToolFinding(
                tool: .provenanceSearch,
                headline: "Fabricated provenance; fake auction records",
                detail: "The claimed provenance (private Amsterdam collection, 1880 → Zurich gallery, 1920 → Swiss private, 1945 → current) cannot be verified. The specific 1920 Zurich sale record cited does not appear in any verifiable Zurich auction archive from that period. One claimed exhibition (The Hague, 1934) lists no such work in the documented exhibition catalogue available in Dutch national archives. The provenance appears to have been fabricated to accompany the forged painting.",
                overlayStyle: .documentView
            )
        ],
        referenceBooks: [
            ReferenceBook(
                title: "The Rembrandt Research Project: Final Report",
                author: "Ernst van Alphen (ed.)",
                coverColor: Color(red: 0.35, green: 0.25, blue: 0.10),
                synopsis: "Documents the findings of the Rembrandt Research Project (1968–2014), which systematically re-examined every claimed Rembrandt painting and reduced the authenticated corpus from over 600 to approximately 340 works.",
                pages: [
                    BookPage(title: "The Rembrandt Attribution Crisis", content: "In 1968, a team of Dutch scholars launched the Rembrandt Research Project (RRP), applying modern scientific methods to systematically re-examine every claimed Rembrandt. Over 46 years, the team reduced the authenticated Rembrandt corpus from over 600 paintings to approximately 340. Dozens of works previously in major museum collections — and authenticated by the greatest Rembrandt scholars of previous generations — were removed from the canon."),
                    BookPage(title: "Self-Portraits as Target", content: "Rembrandt is the most self-portrayed artist in Western history, with over 90 self-portraits in various media. This abundance makes self-portraits both a well-documented type and an attractive target for forgers — there is a large authenticated reference corpus to imitate, and collectors deeply desire a Rembrandt 'face.' Self-portraits on authenticated 17th-century canvases are a documented forgery strategy."),
                    BookPage(title: "The Authentic Canvas Trick", content: "A sophisticated forgery strategy is to use authentic period materials as support. Old canvases can be acquired (from landscapes, minor portraits, or damaged works), stripped or painted over, and then repainted with a desired composition. The authentic canvas and ground will survive technical examination; only the paint layer analysis will reveal the deception. This strategy has been documented in multiple major Rembrandt forgery investigations.")
                ],
                isRelevant: true
            ),
            ReferenceBook(
                title: "Rembrandt: The Complete Self-Portraits",
                author: "H. Perry Chapman",
                coverColor: Color(red: 0.5, green: 0.35, blue: 0.15),
                synopsis: "The definitive catalogue of Rembrandt's authentic self-portraits, examining their evolution across five decades and their unique significance in the history of art.",
                pages: [
                    BookPage(title: "Why So Many Self-Portraits?", content: "Rembrandt produced more self-portraits than any other major artist in history — more than 90, in paintings, drawings, and etchings, from his earliest known work to within months of his death. Scholars debate the reasons: self-promotion (early career), workshop teaching exercises (posed models free of charge), psychological self-examination, or a systematic exploration of the aging face as spiritual autobiography. Possibly all of these."),
                    BookPage(title: "The Late Self-Portraits", content: "Rembrandt's late self-portraits (1650s–1669) are among the most psychologically penetrating works in Western art. Painted after his bankruptcy (1656) and the deaths of his partner Hendrickje and his son Titus, they show a man aged by grief and failure yet still fiercely present. The 1659 self-portrait (National Gallery, Washington) and the 1669 self-portrait (Mauritshuis) are the most celebrated.")
                ],
                isRelevant: false
            ),
            ReferenceBook(
                title: "Art Fraud: Cases and Detection Methods",
                author: "Thomas Hoving",
                coverColor: Color(red: 0.20, green: 0.20, blue: 0.20),
                synopsis: "Documents major art forgery cases of the 20th century, from the Han van Meegeren Vermeer forgeries to the rise of sophisticated scientific authentication methods.",
                pages: [
                    BookPage(title: "Han van Meegeren: The Perfect Vermeer", content: "Han van Meegeren (1889–1947) was a Dutch painter who, embittered by critical dismissal, spent years creating flawless Vermeer forgeries. He used period-appropriate 17th-century canvases, mixed his own paint using period pigments, and developed a formula for artificial ageing. His 'Christ at Emmaus' (1937) was authenticated by the leading Vermeer scholar of the day and sold to Rotterdam's Boijmans Museum. Van Meegeren confessed only when accused of selling a 'real' Vermeer to Nazi leaders."),
                    BookPage(title: "UV Light as Detection Tool", content: "Ultraviolet (UV) fluorescence became a standard museum authentication tool from the 1920s onward. Old paint and varnish fluoresce differently from modern materials under UV — aged natural resins show a darkened, matte, uneven glow, while recent synthetic varnishes and modern paints often glow much brighter and more uniformly. UV analysis exposed many forgeries that had passed visual examination by expert eyes.")
                ],
                isRelevant: false
            )
        ],
        expert: ExpertProfile(
            id: UUID(),
            name: "Prof. Ernst Heymann",
            title: "Former Director, Rembrandt Research Project",
            institution: "University of Amsterdam / Retired",
            specialty: "Rembrandt attribution; Dutch 17th-century technical analysis",
            opinion: "I will be direct. The self-portrait as a whole is not — cannot be — by Rembrandt. But I am not saying the canvas is without authentic elements. The background, the clothing — the physical quality of that old paint... it is real. There is a real 17th-century painting beneath this. What someone has done is criminal in the literal sense: they have taken an authentic period canvas and committed fraud upon it. This is a composite work: authentic support, authentic historical underpainting, fraudulent self-portrait elements added in the 20th century.",
            caveat: "My opinion is based on forty years working within the authenticated Rembrandt corpus. The UV results are decisive. But you need the full scientific report before any legal proceeding.",
            cost: 3000
        ),
        auctionRecord: "Authenticated Rembrandt self-portraits: none have appeared at public auction in decades — they are held almost exclusively by major museum institutions. The 1969 sale of a Rembrandt self-portrait at Christie's London established the precedent of extraordinary value ($1.4M in 1969 — equivalent to $11M today). Any new authenticated Rembrandt self-portrait would command $100M+. This work, as a documented composite fraud, has zero art market value.",
        correctAnswer: CorrectAnswer(
            shortAnswer: "Partial Authentic + 20th-century Forgery Overpainting",
            fullAnswer: "This is a composite fraud: an authentic 17th-century Dutch canvas (original composition: a landscape) upon which a fake Rembrandt self-portrait was painted in the 20th century using modern pigments. The UV fluorescence confirms that the facial features were applied recently. The X-ray reveals the authentic landscape beneath. The chemical analysis confirms mixed-period pigments. The provenance is fabricated. This is sophisticated art crime — not a forgery on new materials but a deliberate exploitation of authentic old canvas to create a convincing deception.",
            educationalExplanation: "The most sophisticated art frauds don't start from scratch — they use authentic period materials as a foundation. By painting on a genuine 17th-century canvas, forgers ensure that the support and ground will survive any technical examination. The Rembrandt Research Project (1968–2014) reduced the authenticated Rembrandt corpus from 600+ to approximately 340 works, demonstrating how even the greatest experts of previous generations were deceived. UV fluorescence analysis, X-radiography, and pigment chemistry are now essential tools that make this category of fraud detectable — but only if all methods are applied together."
        ),
        choices: [
            "Authentic Rembrandt self-portrait, c.1658–1662",
            "Complete modern forgery on modern materials",
            "Partial Authentic + 20th-century Forgery Overpainting",
            "Authentic Rembrandt but misattributed date — c.1640"
        ],
        correctChoiceIndex: 2,
        successPayout: 20000,
        failurePenalty: 10000,
        baseXP: 500
    )
}
