--------------------------------------------------------------------
-- |
-- Copyright :  (c) Edward Kmett 2010-2013, Johan Kiviniemi 2013
-- License   :  BSD3
-- Maintainer:  Edward Kmett <ekmett@gmail.com>
-- Stability :  experimental
-- Portability: non-portable
--
--------------------------------------------------------------------
module Data.Logic.Ersatz.Solver
  ( module Data.Logic.Ersatz.Solver.Minisat
  , solveWith
  ) where

import Data.Logic.Ersatz.Decoding
import Data.Logic.Ersatz.Problem
import Data.Logic.Ersatz.Solution
import Data.Logic.Ersatz.Solver.Minisat

solveWith :: Decoding a => Solver IO -> SAT a -> IO (Result, Maybe (Decoded a))
solveWith solver sat = do
  (a, qbf) <- satToIO sat
  (res, litMap) <- solver qbf
  return (res, decode (solutionFrom litMap qbf) a)
