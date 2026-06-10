---
name: research-writing-style
description: Use when writing, editing, or refining research notebooks, research reports, project summaries, technical experiment notes, implementation summaries, or research-related Markdown. Applies especially when the user asks to make research writing natural, specific, Thai-first, grounded in actual outputs, non-AI-sounding, or written from their perspective as the researcher/developer.
---

# Research Writing Style

If `.claude/research-writing-style.md` exists in the current repo, read it first. Otherwise follow this skill.

## Core voice

Write like the person who actually did the research, experiment, dataset work, system design, or implementation.

Use Thai as the main language. Keep English technical terms when they sound more natural (dataset, pipeline, model, API, dashboard, LLM, preprocessing, visualization, deployment, etc.) — do not force awkward Thai translations.

Preferred tone:

- honest
- practical
- research-oriented
- not too formal
- not too casual
- not promotional
- not textbook-like
- not over-polished

Use first-person wording when it helps the section feel natural, but do not overuse it.

Good patterns:

- "ในส่วนนี้ผมตรวจสอบ..."
- "ขั้นตอนนี้ใช้เพื่อดูว่า..."
- "จาก requirement ที่ได้รับ ผมออกแบบ..."
- "ผลลัพธ์ตรงนี้ควรอ่านในฐานะ..."
- "ข้อจำกัดของวิธีนี้คือ..."
- "ส่วนที่ยังต้องทำต่อคือ..."

Avoid external-reviewer style:

- "ผู้วิจัยได้ดำเนินการ..."
- "จากการวิเคราะห์พบว่า..."
- "ระบบดังกล่าวมีศักยภาพ..."
- "โครงการนี้สามารถตอบโจทย์ได้อย่างครอบคลุม..."

## Anti-AI rules

Avoid generic AI-style phrases:

- "จากข้อมูลข้างต้นจะเห็นได้ว่า..."
- "ช่วยให้เข้าใจภาพรวมได้ดียิ่งขึ้น..."
- "สามารถนำไปต่อยอดได้อย่างมีประสิทธิภาพ..."
- "ตอบโจทย์ผู้ใช้งานได้อย่างครอบคลุม..."
- "รองรับการขยายตัวในอนาคตได้อย่างยั่งยืน..."

Use direct, specific wording instead.

Bad:

> กราฟนี้ช่วยให้เข้าใจภาพรวมของข้อมูลได้อย่างชัดเจน และสามารถนำไปใช้วิเคราะห์ต่อยอดในอนาคตได้อย่างมีประสิทธิภาพ

Better:

> กราฟนี้ใช้เช็กว่าแต่ละช่วงเวลามีข้อมูลครบแค่ไหน ก่อนนำไปวิเคราะห์ต่อ จุดที่ต้องระวังคือกราฟนี้บอกเรื่อง data availability ไม่ได้บอกว่าเหตุการณ์หรือค่าที่วัดได้รุนแรงขึ้นหรือลดลง

## Before explaining outputs

Before writing about any chart, table, map, screenshot, diagram, or HTML output, inspect what it actually shows.

Check:

- title
- axis labels
- legend
- color scale
- units
- variables
- date range
- grouping
- filters
- table columns
- map markers
- tooltip content

Then explain only what the output supports.

Rules:

- If the visual shows missing values, explain missing values, not real-world severity.
- If the visual shows coverage, explain data availability, not outcome trends.
- If the visual shows geolocation, explain spatial distribution, not measured value unless the value is actually plotted.
- If the visual shows before/after processing, explain what changed and what still remains.
- If the visual shows model output, explain it as model output, not ground truth.
- If the visual is unclear, mention that the title, label, legend, or caption should be improved.

Do not invent trends, correlations, improvements, or conclusions unless the output clearly supports them.

## Section content checklist

When writing or revising a section, check whether it explains:

- what I did
- why I did it
- what data, method, or system component was involved
- what the result shows
- what the result does not prove
- what limitation remains
- what should be done next

Do not force every point into every small paragraph. Use the checklist to keep the writing grounded.

## Writing about implementation

When summarizing implementation, separate:

- implemented
- partially implemented
- designed only
- not started
- needs verification

Do not claim production-ready unless there is clear evidence.

Good style:

> จาก requirement ที่ได้รับ ผมแยกระบบออกเป็น frontend, backend, database และ data pipeline เพื่อให้แต่ละส่วนรับผิดชอบชัดเจน ตอนนี้ implementation ยังอยู่ในระดับ prototype โดยส่วนที่ทำไปแล้วคือ dashboard, map layer บางส่วน และโครงของ API ส่วนที่ยังต้องทำต่อคือ permission จริง, source management, cache strategy และ testing

Avoid:

> ระบบนี้ถูกพัฒนาให้มีประสิทธิภาพสูง รองรับการทำงานที่หลากหลาย และสามารถขยายตัวในอนาคตได้อย่างครอบคลุม

## Writing about methods and experiments

Explain:

- why this method was chosen
- what input data it uses
- what output it produces
- what assumption it depends on
- what limitation it has

Do not oversell the method.

Good style:

> วิธีนี้ช่วยเติมข้อมูลบางช่วงที่ขาดหายได้ แต่ผลลัพธ์ยังเป็นค่าประมาณ ไม่ใช่ค่าที่ตรวจวัดจริง ดังนั้นการนำไปวิเคราะห์ต่อควรแยกให้ชัดว่าค่าไหนเป็น observed data และค่าไหนเป็น imputed data

## Writing about results

Prefer specific claims:

- "ข้อมูลเพิ่มขึ้นจาก X เป็น Y"
- "missing values ลดลงประมาณ X%"
- "บาง station ยังมีข้อมูลหายต่อเนื่อง"
- "โมเดลยังพลาดในกลุ่มข้อมูลที่..."
- "ผลลัพธ์นี้ยังควรตรวจสอบกับ..."

Avoid unsupported claims:

- "ผลลัพธ์ดีขึ้นอย่างชัดเจน"
- "ระบบทำงานได้อย่างมีประสิทธิภาพ"
- "ข้อมูลมีคุณภาพมากขึ้น"
- "โมเดลสามารถทำนายได้อย่างแม่นยำ"

Only make these claims if metrics or evidence support them.

## Required output format for refining existing work

For each edited section use the template at `{skill_base_dir}/templates/section-revision-format.md`. Include only the relevant issue bullets.

`skill_base_dir` = path shown at skill load: `Base directory for this skill: /path/to/skill`

## Final check

- Thai reads naturally; English terms kept where they sound better.
- Sounds like the person who did the work, not an external reviewer.
- Explanation matches the actual chart/table/output — no invented trends.
- Limitations, missing work, and risks are stated clearly.
- Writing is specific, not generic. Section connects to the next.
