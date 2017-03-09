definition module TypeDB

// Standard libraries
from StdOverloaded import class <, class zero
from StdClass import class Ord

from Data.Map import ::Map
from Data.Maybe import ::Maybe

from GenEq import generic gEq

// CleanTypeUnifier
from Type import ::Type, ::TypeVar, ::TVAssignment, ::TypeDef, class print(..),
  ::ClassContext, ::ClassRestriction, ::ClassOrGeneric, ::Priority

:: TypeDB

:: TypeExtras = { te_priority       :: Maybe Priority
                , te_isconstructor  :: Bool
                , te_isrecordfield  :: Bool
                , te_generic_vars   :: Maybe [TypeVar]
                , te_representation :: Maybe String
                }

:: ExtendedType = ET Type TypeExtras

:: Macro = { macro_as_string :: String
           , macro_extras :: TypeExtras
           }

:: Location = Location Library Module LineNr LineNr Name
            | Builtin                               Name

:: ModuleInfo = { is_core :: Bool }

:: Name         :== String
:: Library      :== String
:: Module       :== String
:: Class        :== String
:: LineNr       :== Maybe Int

instance zero TypeDB
instance zero TypeExtras
instance zero ModuleInfo

instance print (Name, ExtendedType)

getName :: Location -> Name
isBuiltin :: Location -> Bool

functionCount :: TypeDB -> Int
macroCount :: TypeDB -> Int
classCount :: TypeDB -> Int
instanceCount :: TypeDB -> Int
typeCount :: TypeDB -> Int
deriveCount :: TypeDB -> Int
moduleCount :: TypeDB -> Int

filterLocations :: (Location -> Bool) TypeDB -> TypeDB

getFunction :: Location TypeDB -> Maybe ExtendedType
putFunction :: Location ExtendedType TypeDB -> TypeDB
putFunctions :: [(Location, ExtendedType)] TypeDB -> TypeDB
findFunction :: Name TypeDB -> [(Location, ExtendedType)]
findFunction` :: (Location ExtendedType -> Bool) TypeDB
		-> [(Location, ExtendedType)]
findFunction`` :: [(Location ExtendedType -> Bool)] TypeDB
		-> [(Location, ExtendedType)]

getMacro :: Location TypeDB -> Maybe Macro
putMacro :: Location Macro TypeDB -> TypeDB
putMacros :: [(Location, Macro)] TypeDB -> TypeDB
findMacro` :: (Location Macro -> Bool) TypeDB -> [(Location, Macro)]
findMacro`` :: [(Location Macro -> Bool)] TypeDB -> [(Location, Macro)]

getInstances :: Class TypeDB -> [([(Type,String)], [Location])]
putInstance :: Class [(Type,String)] Location TypeDB -> TypeDB
putInstances :: [(Class, [(Type,String)], Location)] TypeDB -> TypeDB

getClass :: Location TypeDB -> Maybe ([TypeVar],ClassContext,[(Name,ExtendedType)])
putClass :: Location [TypeVar] ClassContext [(Name,ExtendedType)] TypeDB -> TypeDB
putClasses :: [(Location, [TypeVar], ClassContext, [(Name,ExtendedType)])] TypeDB -> TypeDB
findClass :: Class TypeDB -> [(Location, [TypeVar], ClassContext, [(Name, ExtendedType)])]
findClass` :: (Location [TypeVar] ClassContext [(Name,ExtendedType)] -> Bool) TypeDB
		-> [(Location, [TypeVar], ClassContext, [(Name, ExtendedType)])]
findClass`` :: [(Location [TypeVar] ClassContext [(Name,ExtendedType)] -> Bool)] TypeDB
		-> [(Location, [TypeVar], ClassContext, [(Name, ExtendedType)])]

findClassMembers` :: (Location [TypeVar] ClassContext Name ExtendedType -> Bool) TypeDB
		-> [(Location, [TypeVar], ClassContext, Name, ExtendedType)]
findClassMembers`` :: [Location [TypeVar] ClassContext Name ExtendedType -> Bool]
		TypeDB -> [(Location, [TypeVar], ClassContext, Name, ExtendedType)]

getType :: Location TypeDB -> Maybe TypeDef
putType :: Location TypeDef TypeDB -> TypeDB
putTypes :: [(Location, TypeDef)] TypeDB -> TypeDB
findType :: Name TypeDB -> [(Location, TypeDef)]
findType` :: (Location TypeDef -> Bool) TypeDB -> [(Location, TypeDef)]
findType`` :: [(Location TypeDef -> Bool)] TypeDB -> [(Location, TypeDef)]
allTypes :: (TypeDB -> [TypeDef])

getDerivations :: Name TypeDB -> [(Type, String, [Location])]
putDerivation :: Name Type String Location TypeDB -> TypeDB
putDerivations :: Name [(Type, String, Location)] TypeDB -> TypeDB
putDerivationss :: [(Name, [(Type, String, Location)])] TypeDB -> TypeDB

getModule :: Library Module TypeDB -> Maybe ModuleInfo
putModule :: Library Module ModuleInfo TypeDB -> TypeDB
findModule` :: (Library Module ModuleInfo -> Bool) TypeDB -> [(Library, Module, ModuleInfo)]

searchExact :: Type TypeDB -> [(Location, ExtendedType)]

getTypeInstances :: Name TypeDB -> [(Class, [(Type,String)], [Location])]
getTypeDerivations :: Name TypeDB -> [(Name, [Location])]

newDb :: TypeDB
openDb :: *File -> *(Maybe TypeDB, *File)
saveDb :: !TypeDB !*File -> *File
