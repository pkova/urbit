#include "all.h"

u3_noun u3wc_mug(u3_noun cor) {
  u3_noun sam = u3r_at(u3x_sam, cor);

  if ( !_(u3a_is_none(sam)) ) {
    return u3m_bail(c3__exit);
  }

  return UNSAFECAT(u3r_mug(sam));
}