////////////////////////////////////////////////////////////////////////////////
// i/n/x.h
//
// This file is in the public domain.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////

// Conventional Axes for Gate Call /////////////////////////////////////////////

#define u3x_pay      UNSAFECAT(3)       //  payload

#define u3x_sam      UNSAFECAT(6)       //  sample
#define u3x_sam_1    UNSAFECAT(6)
#define u3x_sam_2    UNSAFECAT(12)
#define u3x_sam_3    UNSAFECAT(13)
#define u3x_sam_4    UNSAFECAT(24)
#define u3x_sam_5    UNSAFECAT(25)
#define u3x_sam_6    UNSAFECAT(26)
#define u3x_sam_12   UNSAFECAT(52)
#define u3x_sam_13   UNSAFECAT(53)
#define u3x_sam_7    UNSAFECAT(27)
#define u3x_sam_14   UNSAFECAT(54)
#define u3x_sam_15   UNSAFECAT(55)
#define u3x_sam_30   UNSAFECAT(110)
#define u3x_sam_31   UNSAFECAT(111)

#define u3x_con      UNSAFECAT(7)       //  context
#define u3x_con_2    UNSAFECAT(14)      //  context
#define u3x_con_3    UNSAFECAT(15)      //  context
#define u3x_con_sam  UNSAFECAT(30)      //  sample in gate context

#define u3x_bat      UNSAFECAT(2)       //  battery

////////////////////////////////////////////////////////////////////////////////
// Macros //////////////////////////////////////////////////////////////////////

// Word Axis Macros -- For 31-bit Axes Only ////////////////////////////////////

// u3x_dep(): number of axis bits.
#define u3x_dep(a_w)   (c3_bits_word(a_w) - 1)

// u3x_cap(): root axis, 2 or 3.
#define u3x_cap(a_w) ({                       \
  c3_assert( 1 < a_w );                       \
  (0x2 | (a_w >> (u3x_dep(a_w) - 1))); })

// u3x_mas(): remainder after cap.
#define u3x_mas(a_w) ({                       \
  c3_assert( 1 < a_w );                       \
  ( (a_w & ~(1 << u3x_dep(a_w))) | (1 << (u3x_dep(a_w) - 1)) ); })

// u3x_peg(): connect two axes.
#define u3x_peg(a_w, b_w) \
  ( (a_w << u3x_dep(b_w)) | (b_w &~ (1 << u3x_dep(b_w))) )

  /**  Functions.
  **/
    /** u3x_*: read, but bail with c3__exit on a crash.
    **/
#if 1
#     define u3x_h(som)  u3a_h(som)
#     define u3x_t(som)  u3a_t(som)
#else
      /* u3x_h (u3h): head.
      */
        u3_noun
        u3x_h(u3_noun som);

      /* u3x_t (u3t): tail.
      */
        u3_noun
        u3x_t(u3_noun som);
#endif
      /* u3x_good(): test for u3_none.
      */
        u3_noun
        u3x_good(u3_weak som);

      /* u3x_at (u3at): fragment.
      */
        u3_noun
        u3x_at(u3_noun axe, u3_noun som);

      /* u3x_cell():
      **
      **   Divide `a` as a cell `[b c]`.
      */
        void
        u3x_cell(u3_noun  a,
                   u3_noun* b,
                   u3_noun* c);

      /* u3x_trel():
      **
      **   Divide `a` as a trel `[b c d]`, or bail.
      */
        void
        u3x_trel(u3_noun  a,
                   u3_noun* b,
                   u3_noun* c,
                   u3_noun* d);

      /* u3x_qual():
      **
      **   Divide `a` as a quadruple `[b c d e]`.
      */
        void
        u3x_qual(u3_noun  a,
                   u3_noun* b,
                   u3_noun* c,
                   u3_noun* d,
                   u3_noun* e);

      /* u3x_quil():
      **
      **   Divide `a` as a quintuple `[b c d e f]`.
      */
        void
        u3x_quil(u3_noun  a,
                   u3_noun* b,
                   u3_noun* c,
                   u3_noun* d,
                   u3_noun* e,
                   u3_noun* f);

      /* u3x_hext():
      **
      **   Divide `a` as a hextuple `[b c d e f g]`.
      */
        void
        u3x_hext(u3_noun  a,
                   u3_noun* b,
                   u3_noun* c,
                   u3_noun* d,
                   u3_noun* e,
                   u3_noun* f,
                   u3_noun* g);