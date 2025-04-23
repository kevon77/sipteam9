// import 'package:flutter/material.dart';

// class DiseaseInfoScreen extends StatelessWidget {
//   final String diseaseName;
//   final Map<String, dynamic> questionnaire;

//   DiseaseInfoScreen({
//     Key? key,
//     required this.diseaseName,
//     required this.questionnaire,
//   }) : super(key: key);

//   final Map<String, Map<String, String>> diseaseData = {
//     "acne": {
//       "description": "acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells.",
//       "tips": "wash your face twice daily, avoid touching your face, use non-comedogenic products, and stay hydrated."
//     },
//     "eczema": {
//       "description": "eczema causes patches of skin to become inflamed, itchy, cracked, and rough.",
//       "tips": "moisturize regularly, avoid harsh soaps, and manage stress to reduce flare-ups."
//     },
//     "psoriasis": {
//       "description": "psoriasis is a chronic autoimmune condition that causes the rapid buildup of skin cells.",
//       "tips": "keep skin moisturized, avoid triggers like stress, and use medicated creams or phototherapy as prescribed."
//     },
//     "melanoma": {
//       "description": "melanoma is a serious form of skin cancer that begins in the melanocytes (pigment-producing cells).",
//       "tips": "seek immediate medical advice, protect skin from uv rays, and monitor moles for changes."
//     },
//     "dermatitis": {
//       "description": "dermatitis refers to inflammation of the skin, leading to itchy and red patches.",
//       "tips": "avoid irritants, moisturize, and use anti-inflammatory creams."
//     },
//     "basal cell carcinoma": {
//       "description": "a type of skin cancer that begins in the basal cells — a type of cell within the skin that produces new skin cells.",
//       "tips": "seek medical treatment, avoid sun exposure, and monitor skin regularly."
//     },
//     "squamous cell carcinoma": {
//       "description": "a form of skin cancer arising from the squamous cells in the outer layer of skin.",
//       "tips": "consult a dermatologist, protect skin from sun, and follow treatment plans strictly."
//     },
//     "rosacea": {
//       "description": "rosacea is a chronic skin condition that causes facial redness and visible blood vessels.",
//       "tips": "avoid triggers like spicy foods and heat, use gentle skincare, and follow a prescribed treatment."
//     },
//     "vitiligo": {
//       "description": "vitiligo is a condition in which the skin loses its pigment cells, resulting in discolored patches.",
//       "tips": "use sunscreen, consider cosmetic cover-ups, and consult a dermatologist for treatment options."
//     },
//     "pimple": {
//       "description": "a pimple is a small pustule or papule that develops when sebaceous glands become clogged and infected.",
//       "tips": "keep your skin clean, avoid popping pimples, and use acne-targeted skincare."
//     },
//     "blackhead": {
//       "description": "blackheads are small bumps on the skin caused by clogged hair follicles.",
//       "tips": "use salicylic acid or retinoids, avoid heavy oils, and cleanse regularly."
//     },
//     "whitehead": {
//       "description": "whiteheads are closed comedones that form when dead skin cells, oil, and bacteria become trapped within pores.",
//       "tips": "exfoliate gently, use oil-free products, and maintain a consistent skincare routine."
//     },
//     "blemish": {
//       "description": "a blemish is any type of mark, spot, discoloration, or flaw on the skin.",
//       "tips": "treat with topical creams, avoid touching the skin, and keep the skin clean."
//     },
//     "cystic acne": {
//       "description": "cystic acne is a severe form of acne characterized by deep, inflamed cysts under the skin.",
//       "tips": "consult a dermatologist, avoid squeezing, and follow a medicated skincare plan."
//     },
//     "comedone": {
//       "description": "comedones are hair follicles that are clogged with oil, dead skin, and bacteria.",
//       "tips": "use non-comedogenic products, cleanse twice daily, and exfoliate weekly."
//     },
//     "papule": {
//       "description": "a papule is a small, raised, solid pimple that does not contain pus.",
//       "tips": "clean the area gently, avoid scrubbing, and consider topical acne treatments."
//     },
//     "nodule": {
//       "description": "a nodule is a larger, hard bump under the skin often caused by acne.",
//       "tips": "do not squeeze, use prescribed treatments, and visit a dermatologist for severe cases."
//     },
//     "lupus": {
//       "description": "lupus is an autoimmune disease that can cause skin rashes, especially on the face.",
//       "tips": "avoid sunlight, use prescribed medication, and manage stress levels."
//     },
//     "ringworm": {
//       "description": "ringworm is a fungal infection that causes a red or silvery ring-like rash on the skin.",
//       "tips": "keep the area dry and clean, use antifungal creams, and avoid sharing personal items."
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     final diseaseKey = diseaseData.keys.firstWhere(
//       (key) => diseaseName.toLowerCase().contains(key),
//       orElse: () => '',
//     );

//     final info = diseaseData[diseaseKey];
//     final name = questionnaire['name'] ?? 'User';
//     final ageRaw = questionnaire['age'];
//     final int? age = int.tryParse(ageRaw.toString());
//     final symptoms = questionnaire['symptoms'] ?? [];

//     String advice = '';

//     if (symptoms is List) {
//       if (symptoms.contains('Itching')) {
//         advice += "- Avoid scratching the affected area.\n";
//       }
//       if (symptoms.contains('Redness')) {
//         advice += "- Use a calming moisturizer or aloe vera.\n";
//       }
//       if (symptoms.contains('Rashes')) {
//         advice += "- Keep skin clean and avoid tight clothing.\n";
//       }
//       if (symptoms.contains('Peeling')) {
//         advice += "- Apply thick moisturizers and avoid hot showers.\n";
//       }
//       if (symptoms.contains('Blisters')) {
//         advice += "- Avoid popping blisters and keep the area clean.\n";
//       }
//     }

//     if (age != null) {
//       if (age < 12) {
//         advice += "- As a child, always consult a pediatric dermatologist.\n";
//       } else if (age < 20) {
//         advice += "- Teenage skin needs gentle but consistent care routines.\n";
//       } else if (age >= 60) {
//         advice += "- Senior skin is more delicate—use extra moisturizers and sun protection.\n";
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       appBar: AppBar(
//         title: const Text("More Info"),
//         backgroundColor: Colors.green[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: info != null
//             ? SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       diseaseKey.toUpperCase(),
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text("About:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Text(info['description']!, style: const TextStyle(fontSize: 16)),
//                     const SizedBox(height: 20),
//                     const Text("General Tips:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     Text(info['tips']!, style: const TextStyle(fontSize: 16)),
//                     const SizedBox(height: 30),

//                     // Personalized Advice Panel
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.green.shade300),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Note for $name (Age: ${age ?? 'Unknown'}):",
//                             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Based on your symptoms (${symptoms.join(", ")}), here is some additional advice:",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             advice.isNotEmpty ? advice : "No specific advice could be generated.",
//                             style: const TextStyle(fontSize: 16, color: Colors.black87),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const Center(child: Text("No additional info available.")),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DiseaseInfoScreen extends StatelessWidget {
  final String diseaseName;
  final Map<String, dynamic> questionnaire;

  DiseaseInfoScreen({
    Key? key,
    required this.diseaseName,
    required this.questionnaire,
  }) : super(key: key);

  final Map<String, Map<String, String>> diseaseData = {
    "eczema": {
      "description": "acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells.",
      "tips": "wash your face twice daily, avoid touching your face, use non-comedogenic products, and stay hydrated."
    },
    // ... (other disease entries remain unchanged for brevity)
    "ringworm": {
      "description": "ringworm is a fungal infection that causes a red or silvery ring-like rash on the skin.",
      "tips": "keep the area dry and clean, use antifungal creams, and avoid sharing personal items."
    },
  };

  @override
  Widget build(BuildContext context) {
    final diseaseKey = diseaseData.keys.firstWhere(
      (key) => diseaseName.toLowerCase().contains(key),
      orElse: () => '',
    );

    final info = diseaseData[diseaseKey];
    final name = questionnaire['name'] ?? 'User';
    final ageRaw = questionnaire['age'];
    final int? age = int.tryParse(ageRaw.toString());
    final symptoms = questionnaire['symptoms'] ?? [];

    // Symptom-based advice
    String symptomAdvice = '';
    if (symptoms is List) {
      if (symptoms.contains('Itching')) {
        symptomAdvice += "- Avoid scratching the affected area.\n";
      }
      if (symptoms.contains('Redness')) {
        symptomAdvice += "- Use a calming moisturizer or aloe vera.\n";
      }
      if (symptoms.contains('Rashes')) {
        symptomAdvice += "- Keep skin clean and avoid tight clothing.\n";
      }
      if (symptoms.contains('Peeling')) {
        symptomAdvice += "- Apply thick moisturizers and avoid hot showers.\n";
      }
      if (symptoms.contains('Blisters')) {
        symptomAdvice += "- Avoid popping blisters and keep the area clean.\n";
      }
    }

    // Age-based advice
    String ageAdvice = '';
    if (age != null) {
      if (age < 12) {
        ageAdvice = "- As a child, always consult a pediatric dermatologist.";
      } else if (age < 20) {
        ageAdvice = "- Teenage skin needs gentle but consistent care routines.";
      } else if (age >= 60) {
        ageAdvice = "- Senior skin is more delicate—use extra moisturizers and sun protection.";
      }
    }

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("More Info"),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: info != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diseaseKey.toUpperCase(),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 16),
                    const Text("About:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(info['description']!, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    const Text("General Tips:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(info['tips']!, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 30),

                    // Symptom Advice Panel
                    if (symptomAdvice.isNotEmpty) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Advice for $name based on symptoms:",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(symptomAdvice, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Age Advice Panel
                    if (ageAdvice.isNotEmpty) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Advice based on age (${age ?? 'Unknown'}):",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(ageAdvice, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              )
            : const Center(child: Text("No additional info available.")),
      ),
    );
  }
}

