# - Try to find the gmcs and gacutil
#
# defines
#
# CSharp_FOUND - system has mono, mcs, gmcs and gacutil
# GMCS_PATH - where to find 'gmcs'
# GACUTIL_PATH - where to find 'gacutil'
#
# copyright (c) 2007 Arno Rehn arno@arnorehn.de
#
# Redistribution and use is allowed according to the terms of the GPL license.
#
# Modified by canming to find .NET on Windows
# copyright (c) 2009 - 2012 Canming Huang support@emgu.com

IF(WIN32)
FIND_PROGRAM (CSC_EXECUTABLE_20 csc
$ENV{windir}/Microsoft.NET/Framework/v2.0.50727/
"C:/WINDOWS/Microsoft.NET/Framework/v2.0.50727")
IF(CSC_EXECUTABLE_20)
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_20})
ENDIF()

FIND_PROGRAM (CSC_EXECUTABLE_35 csc
$ENV{windir}/Microsoft.NET/Framework64/v3.5/
"C:/Windows/Microsoft.NET/Framework64/v3.5"
$ENV{windir}/Microsoft.NET/Framework/v3.5/
"C:/Windows/Microsoft.NET/Framework/v3.5"
)
#MESSAGE( "$ENV{programfiles}/Reference Assemblies/Microsoft/Framework/.NETFramework/v3.5/Profile/Client/" )
FIND_FILE (CSC_MSCORLIB_35 mscorlib.dll
"$ENV{programfiles}/Reference Assemblies/Microsoft/Framework/.NETFramework/v3.5/Profile/Client/"
"C:/Program Files (x86)/Reference Assemblies/Microsoft/Framework/.NETFramework/v3.5/Profile/Client/"
)
IF(CSC_EXECUTABLE_35)
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_35})
ENDIF()

FIND_PROGRAM (CSC_EXECUTABLE_40 csc 
$ENV{windir}/Microsoft.NET/Framework64/v4.0.30319/
"C:/Microsoft.NET/Framework64/v4.0.30319/"
$ENV{windir}/Microsoft.NET/Framework/v4.0.30319/
"C:/Microsoft.NET/Framework/v4.0.30319/")
IF(CSC_EXECUTABLE_40)
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_40})
ENDIF()

IF(CSC_EXECUTABLE_20 AND CSC_PREFERRED_VERSION MATCHES "2.0")
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_20})
ENDIF()

IF(CSC_EXECUTABLE_35 AND CSC_PREFERRED_VERSION MATCHES "3.5")
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_35})
ENDIF()

IF(CSC_EXECUTABLE_40 AND CSC_PREFERRED_VERSION MATCHES "4.0")
SET (CSC_EXECUTABLE ${CSC_EXECUTABLE_40})
ENDIF()

ELSE(WIN32)
FIND_PROGRAM (CSC_EXECUTABLE mcs)
ENDIF(WIN32)

FIND_PROGRAM (GACUTIL_EXECUTABLE gacutil 
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0/Bin" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0A/Bin"
"C:/Program Files/Microsoft SDKs/Windows/v6.0/bin" 
"C:/Program Files/Microsoft SDKs/Windows/v6.0A/bin" 
/usr/lib/mono/2.0
/usr/bin)

FIND_PROGRAM (AL_EXECUTABLE al
"C:/Program Files/Microsoft SDKs/Windows/v7.0/bin"
"C:/Program Files/Microsoft SDKs/Windows/v7.0A/bin"
"C:/Program Files/Microsoft SDKs/Windows/v6.0/bin" 
"C:/Program Files/Microsoft SDKs/Windows/v6.0A/bin"
"C:/WINDOWS/Microsoft.NET/Framework/v2.0.50727"
"C:/Windows/Microsoft.NET/Framework/v3.5" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v7.0/Bin" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v7.0A/Bin"
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0/Bin" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0A/Bin"
$ENV{windir}/Microsoft.NET/Framework/v3.5
$ENV{windir}/Microsoft.NET/Framework/v2.0.50727
/usr/lib/mono/2.0
/usr/bin)

FIND_PROGRAM (RESGEN_EXECUTABLE resgen
"C:/Program Files/Microsoft SDKs/Windows/v7.0/bin"
"C:/Program Files/Microsoft SDKs/Windows/v7.0A/bin"
"C:/Program Files/Microsoft SDKs/Windows/v6.0/bin" 
"C:/Program Files/Microsoft SDKs/Windows/v6.0A/bin"
"C:/Program Files/Microsoft Visual Studio 8/SDK/v2.0/Bin"
"$ENV{programfiles}/Microsoft SDKs/Windows/v7.0/Bin" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v7.0A/Bin"
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0/Bin" 
"$ENV{programfiles}/Microsoft SDKs/Windows/v6.0A/Bin"
"$ENV{programfiles}/Microsoft Visual Studio 8/SDK/v2.0/Bin"
/usr/bin)

# ----------------------------------------------------------------------------
#  FIND MSBUILD
# ----------------------------------------------------------------------------
FIND_PROGRAM(MSBUILD_PROGRAM
  NAMES MSBuild
  HINTS
#  comment out MSBUILD 4.0 for SHFB 
  "$ENV{SYSTEMROOT}/Microsoft.NET/Framework64/v4.0.30319"
  "C:/WINDOWS/Microsoft.NET/Framework64/v4.0.30319"
  "$ENV{SYSTEMROOT}/Microsoft.NET/Framework/v4.0.30319"
  "C:/WINDOWS/Microsoft.NET/Framework/v4.0.30319"
#  "$ENV{SYSTEMROOT}/Microsoft.NET/Framework/v3.5"
#  "C:/WINDOWS/Microsoft.NET/Framework/v3.5"
  )
  
SET (CSharp_FOUND FALSE)

IF (CSC_EXECUTABLE AND AL_EXECUTABLE AND RESGEN_EXECUTABLE)
	SET (CSharp_FOUND TRUE)
ENDIF (CSC_EXECUTABLE AND AL_EXECUTABLE AND RESGEN_EXECUTABLE)

IF (NOT CSharp_FIND_QUIETLY)
   IF (CSC_EXECUTABLE)
	MESSAGE(STATUS "Found csc: ${CSC_EXECUTABLE}")
   ENDIF (CSC_EXECUTABLE)
   IF (GACUTIL_EXECUTABLE)
	MESSAGE(STATUS "Found gacutil: ${GACUTIL_EXECUTABLE}")
   ENDIF (GACUTIL_EXECUTABLE)
   IF (AL_EXECUTABLE)
   	MESSAGE(STATUS "Found al: ${AL_EXECUTABLE}")
   ENDIF (AL_EXECUTABLE)
   IF (RESGEN_EXECUTABLE)
	MESSAGE(STATUS "Found resgen: ${RESGEN_EXECUTABLE}")
   ENDIF(RESGEN_EXECUTABLE)
ENDIF (NOT CSharp_FIND_QUIETLY)

IF (CSharp_FOUND)
ELSE (CSharp_FOUND)
	IF (CSharp_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "Could not find one or more of the
following programs: csc, gacutil, al, resgen")
	ENDIF (CSharp_FIND_REQUIRED)
ENDIF (CSharp_FOUND)

MARK_AS_ADVANCED(CSC_EXECUTABLE AL_EXECUTABLE GACUTIL_EXECUTABLE)


