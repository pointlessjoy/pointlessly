# Pointless Joy — 서비스 기획서

## 한 줄 요약

"나를 기쁘게 하는 아름답지만 무용한 것은?" — 이 질문에 답하는 과정에서 자기 자신을 발견하는 서비스.

---

## 1. 핵심 철학

이 서비스는 답을 수집하는 플랫폼이 아니다. **질문을 던지는 서비스**다.

스승님이 제자에게 했던 것처럼, 이 서비스는 사용자에게 하나의 질문을 건넨다. 사용자는 답하려 하고, 답하는 과정에서 유용과 무용의 경계가 흔들리는 것을 경험하고, 결국 자신의 진짜 모양을 마주하게 된다.

### 핵심 인사이트
- **세 조건의 역설**: 기쁨 + 아름다움 + 무용은 논리적으로 동시에 성립하지 않는다. 기쁨을 주는 순간 이미 쓸모가 생기니까. 하지만 그 모순 속에서 답을 찾으려는 행위 자체가 의미를 만든다.
- **답이 곧 자화상**: 쓸모 있어서 하는 것은 누구나 설명할 수 있다. 무용한데도 자꾸 하는 것 — 그것이 꾸밀 수 없는 그 사람의 진짜 모양이다.
- **무용함의 회복**: 아이를 낳고, 회사에서 쓸모를 증명하며 살다 보면, 무용한 것을 하는 순간이 죄악처럼 느껴진다. 이 서비스는 그 무용함을 다시 아름다움으로 되돌려준다.

---

## 2. 사용자 경험 (UX Flow)

### 우선순위
1. 질문을 통한 자기 탐색 여정 (핵심)
2. 다른 사람들의 답을 읽는 경험
3. 내 답이 아름다운 결과물로 돌아오는 것
4. 이 철학을 알려주는 콘텐츠

### Phase 1: 질문을 만나다 (Landing)

```
[화면]
조용한 배경. 천천히 나타나는 텍스트.

"나를 기쁘게 하는
 아름답지만
 무용한 것은?"

            [답하기]
```

- 첫 화면은 질문만 있다. 설명 없음. 메뉴 없음. 로고도 최소화.
- 질문이 천천히 나타나면서 사용자가 읽고 멈추는 시간을 확보한다.
- "답하기" 버튼 하나.

### Phase 2: 답하는 여정 (Journey)

단순한 입력 폼이 아니라, **대화처럼 흘러가는 구조**.

```
[Step 1]
"먼저, 떠오르는 것을 하나 적어보세요.
 깊이 생각하지 않아도 괜찮아요."

[입력]
_______________

[다음]
```

```
[Step 2 — 되물음]
"그것이 당신을 기쁘게 하나요?"
→ 네

"그것이 아름다운가요?"
→ 네

"그것은 무용한가요?"
→ ... (여기서 멈칫하게 된다)

"기쁨을 준다면 이미 쓸모가 있는 것 아닐까요?"
```

```
[Step 3 — 깨달음의 순간]
"그래도 괜찮아요.
 무용한 줄 알면서도 손이 가는 것.
 이유를 댈 수 없는데 그냥 좋은 것.
 그것이 당신의 진짜 모양이에요."

"다시 한번 적어볼까요?
 혹은 처음 답 그대로도 좋아요."

[입력 또는 유지]
```

```
[Step 4 — 마무리]
"마지막으로, 이 답을 한 문장으로 표현해주세요."

[입력]
"당신의 아름답지만 무용한 것: _______________"

[완료]
```

### Phase 3: 결과물 (Output)

사용자의 답이 아름다운 형태로 돌아온다.

**엽서 형태**: 사용자의 답이 포스터/엽서 디자인에 담겨 나온다.
- 우리가 만든 poster.html 스타일
- 답의 길이, 분위기에 따라 레이아웃 변형
- 다운로드 가능 (이미지/PDF)
- 공유 가능 (링크, SNS)

**선택적 추가**:
- AI가 사용자의 답을 바탕으로 짧은 시를 써준다
- 또는 한 줄 감상을 붙여준다

### Phase 4: 다른 사람의 답 (Archive)

```
[화면]
다른 사람들의 아름답지만 무용한 것들

"남편" — 익명
"비 오는 날 창문 보기" — 익명
"쿠션어" — 익명
"안 읽을 책 사기" — 익명
"새벽 3시 라면" — 익명
...
```

- 스크롤하면 답들이 하나씩 나타난다
- 각 답을 누르면 그 사람의 전체 답변(한 문장)을 볼 수 있다
- 공감(♡)만 가능. 댓글 없음. 조용한 공간.
- 익명 기본, 닉네임 선택 가능

### Phase 5: 콘텐츠 (About / Story)

- 이 질문의 배경 이야기 (수필을 바탕으로)
- "무용이란 무엇인가" — 철학적 배경
- 원본 수필, 시 등 콘텐츠

---

## 3. 핵심 페이지 구조

```
/ (랜딩 — 질문)
├── /answer (답하는 여정 — 스텝별 진행)
├── /result/:id (내 결과물 — 엽서/포스터)
├── /archive (다른 사람들의 답)
├── /story (이 질문의 이야기)
└── /about (서비스 소개)
```

---

## 4. 기술 스택 (제안)

### Frontend
- **Next.js** (React 기반, SSR/SSG)
- **Tailwind CSS** (커스텀 테마)
- **Framer Motion** (애니메이션 — 텍스트 등장, 페이지 전환)
- 커스텀 폰트: Noto Serif KR + Cormorant Garamond

### Backend
- **Next.js API Routes** 또는 별도 서버
- **Database**: Supabase (PostgreSQL) 또는 PlanetScale
  - 답변 저장, 공감 수, 익명/닉네임 관리

### AI (결과물 생성)
- **Claude API**: 사용자의 답을 바탕으로 시/감상 생성
- 모델: claude-sonnet-4-20250514 (비용 효율)

### 결과물 이미지 생성
- **html2canvas** 또는 **Satori (by Vercel)**: 엽서/포스터를 이미지로 변환
- OG Image로도 활용 (SNS 공유 시 미리보기)

### 배포
- **Vercel** (Next.js 최적화) 또는 **AWS EC2** (Sue 경험 기반)

### 인프라
- 도메인: pointlessjoy.com / beautifully-pointless.com 등 확인 필요

---

## 5. 데이터 모델 (초안)

```sql
-- 답변
CREATE TABLE answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  raw_answer TEXT NOT NULL,          -- 처음 떠오른 답
  final_answer TEXT,                 -- 다시 적은 답 (선택)
  one_sentence TEXT,                 -- 한 문장 표현
  display_name VARCHAR(50),          -- 닉네임 (nullable = 익명)
  likes_count INTEGER DEFAULT 0,
  is_public BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 공감
CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID REFERENCES answers(id),
  session_id VARCHAR(100),           -- 비로그인 기반 중복 방지
  created_at TIMESTAMPTZ DEFAULT now()
);

-- AI 생성 콘텐츠
CREATE TABLE generated_content (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id UUID REFERENCES answers(id),
  content_type VARCHAR(20),          -- 'poem', 'reflection', 'postcard'
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

---

## 6. 디자인 시스템

### 컬러
```css
:root {
  --bg:          #f5f0ea;   /* 따뜻한 크림 */
  --bg-warm:     #ede6db;   /* 워시 배경 */
  --text:        #2c2824;   /* 깊은 갈색 */
  --text-light:  #6b6057;   /* 보조 텍스트 */
  --text-faint:  #a89d91;   /* 희미한 텍스트 */
  --accent:      #c4a882;   /* 따뜻한 골드 */
  --accent-deep: #8b7355;   /* 깊은 골드 */
  --line:        #d4c9ba;   /* 구분선 */
}
```

### 타이포그래피
- **한글**: Noto Serif KR (200, 300, 400, 500)
- **영문/장식**: Cormorant Garamond (300, 400 italic)
- **본문**: 17px, line-height 2.0
- **질문**: clamp(1.4rem, 3.5vw, 1.9rem)

### 톤 & 무드
- 한지 위에 먹으로 쓴 글씨 같은 느낌
- 따뜻하지만 조용한. 미니멀하지만 차갑지 않은
- 텍스트가 천천히 나타나고, 사용자가 읽는 속도를 존중
- **이 서비스를 사용하는 시간 자체가 "아름답지만 무용한 시간"이 되어야 한다**

### 애니메이션 원칙
- 빠르지 않게. 텍스트 등장은 1~2초
- 스크롤 기반 등장 (Intersection Observer)
- 시 한 줄씩 나타나는 효과 (200ms 간격)
- 페이지 전환은 부드러운 fade

---

## 7. MVP 범위

### v0.1 — 최소 기능
- [ ] 랜딩 페이지 (질문)
- [ ] 답하기 여정 (4 스텝)
- [ ] 결과물 엽서 생성 (HTML → 이미지)
- [ ] 결과물 공유 (링크)
- [ ] 아카이브 페이지 (다른 사람 답 보기)
- [ ] 공감(♡) 기능
- [ ] 반응형 (모바일 우선)

### v0.2 — 확장
- [ ] AI 시 생성 (Claude API)
- [ ] 엽서 템플릿 다양화
- [ ] SNS 공유 최적화 (OG Image)
- [ ] /story 페이지 (수필/철학 콘텐츠)

### v0.3 — 성장
- [ ] 다국어 (영어 — "What is beautiful but pointless, that brings you joy?")
- [ ] 주간 뉴스레터 (이번 주의 답들)
- [ ] 엽서 실물 인쇄 서비스 (선택)

---

## 8. 핵심 문장 아카이브 (서비스 내 활용)

여정 중간, 로딩, 빈 화면 등에 활용할 수 있는 문장들:

- "아무것도 남기지 않았는데 전부 남아 있다"
- "답할 때마다 무용이 무너지고 무너질 때마다 아름다워지므로"
- "쓸모를 물으면 아무것도 아닌 것들이 나를 여기까지 데려왔다"
- "내 말이 너를 다치게 하지 않기를 바라는 마음이 단어 하나에 들어가 있다"
- "무용하지만 아름답고 기쁘다 — 존재 자체가 좋다는 뜻이다"
- "그것이 꾸미거나 포장할 수 없는, 그 사람의 진짜 모양이다"
- "쓸모를 증명하지 않아도 괜찮은 시간을 스스로에게 허락할 수 있겠느냐고"

---

## 9. 레퍼런스 느낌

- **36 Questions** (NYT) — 질문을 통한 친밀감 실험, 스텝별 진행
- **Humans of New York** — 짧은 답변이 만드는 깊은 울림
- **PostSecret** — 익명의 고백이 만드는 연대감
- **차분한 웹 경험**: 읽는 속도를 존중하는 UI

---

## 10. 프로젝트 구조 (Claude Code용)

```
pointless-joy/
├── README.md
├── package.json
├── next.config.js
├── tailwind.config.js
├── public/
│   └── fonts/
├── src/
│   ├── app/
│   │   ├── page.tsx              ← 랜딩 (질문)
│   │   ├── answer/
│   │   │   └── page.tsx          ← 답하기 여정
│   │   ├── result/
│   │   │   └── [id]/page.tsx     ← 결과물
│   │   ├── archive/
│   │   │   └── page.tsx          ← 아카이브
│   │   ├── story/
│   │   │   └── page.tsx          ← 이야기
│   │   └── api/
│   │       ├── answers/route.ts  ← 답변 CRUD
│   │       ├── likes/route.ts    ← 공감
│   │       └── generate/route.ts ← AI 생성
│   ├── components/
│   │   ├── Question.tsx
│   │   ├── JourneyStep.tsx
│   │   ├── Postcard.tsx
│   │   ├── ArchiveCard.tsx
│   │   └── AnimatedText.tsx
│   ├── lib/
│   │   ├── db.ts
│   │   ├── claude.ts
│   │   └── imageGen.ts
│   └── styles/
│       └── globals.css
├── content/
│   ├── essay.md
│   ├── essay_claude.md
│   ├── poem.md
│   └── letter.md
└── design/
    └── poster.html
```

---

## 이 서비스의 궁극적 목표

스승님이 제자에게 질문 하나를 던졌고, 그 질문은 시간이 지나 다른 사람에게 전해졌다. 이 서비스는 그 전달을 계속하는 것이다.

누군가 이 페이지를 열고, 질문을 읽고, 잠시 멈추고, 답을 적는다. 그 시간 자체가 이미 "아름답지만 무용한 것"이다. 그리고 그것으로 충분하다.
