# typed: strict

# I have no idea what real world thing this example is trying to model.
# I took it originally from https://github.com/sorbet/sorbet/issues/2572
# That being said, it's still code, so I figured it'd be better to test
# than not to test.

module A
  extend(T::Sig)
  extend(T::Generic)
  abstract!
  sealed!
end

module B
  extend(T::Sig)
  extend(T::Generic)
  abstract!
  sealed!
end

class AImpl
  extend(T::Sig)
  extend(T::Generic)
  include(A)
end

class BImpl
  extend(T::Sig)
  extend(T::Generic)
  include(B)
end

extend(T::Sig)

sig { params(elem: T.any(A, B)).returns(T::Boolean) }
def takes_good?(elem)
  case elem
  when AImpl
    true
  when BImpl
    false
  else
    T.absurd(elem)
  end
end

sig { params(elem: T.any(A, B)).returns(T::Boolean) }
def takes_bad?(elem)
  case elem
  when AImpl
    true
  # when BImpl
  #   false
  else
    T.absurd(elem) # error: the type `BImpl` wasn't handled
  end
end
