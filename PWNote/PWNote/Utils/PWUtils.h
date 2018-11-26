//
//  PWUtils.h
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef PWUtils_h
#define PWUtils_h
#define weakify(...) \\
autoreleasepool {} \\
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)

#define strongify(...) \\
try {} @finally {} \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \\
_Pragma("clang diagnostic pop")

#endif /* PWUtils_h */
