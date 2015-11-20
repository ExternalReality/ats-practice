module Paths_high_spec (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/externalreality/dev/ats-practice/high-spec/.stack-work/install/x86_64-linux/lts-3.5/7.10.2/bin"
libdir     = "/home/externalreality/dev/ats-practice/high-spec/.stack-work/install/x86_64-linux/lts-3.5/7.10.2/lib/x86_64-linux-ghc-7.10.2/high-spec-0.1.0.0-FCpJlY2l3p69pbHH8awCzQ"
datadir    = "/home/externalreality/dev/ats-practice/high-spec/.stack-work/install/x86_64-linux/lts-3.5/7.10.2/share/x86_64-linux-ghc-7.10.2/high-spec-0.1.0.0"
libexecdir = "/home/externalreality/dev/ats-practice/high-spec/.stack-work/install/x86_64-linux/lts-3.5/7.10.2/libexec"
sysconfdir = "/home/externalreality/dev/ats-practice/high-spec/.stack-work/install/x86_64-linux/lts-3.5/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "high_spec_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "high_spec_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "high_spec_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "high_spec_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "high_spec_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
