// RUN: rm -rf %t && mkdir -p %t/stats-pre && mkdir -p %t/stats-post
//
// Compile swiftmodule with decl member name tables
// RUN: %target-swift-frontend -emit-module -o %t/NamedLazyMembers.swiftmodule -enable-named-lazy-member-loading %S/Inputs/NamedLazyMembers/NamedLazyMembers.swift
//
// Check that named-lazy-member-loading reduces the number of Decls deserialized
// RUN: %target-swift-frontend -typecheck -I %t -typecheck -stats-output-dir %t/stats-pre %s
// RUN: %target-swift-frontend -typecheck -I %t -enable-named-lazy-member-loading -stats-output-dir %t/stats-post %s
// RUN: %utils/process-stats-dir.py --evaluate-delta 'NumDeclsDeserialized < -10' %t/stats-pre %t/stats-post

// REQUIRES: rdar35799113

import NamedLazyMembers

public func test(i: DerivedClass.derivedMemberType1) -> DerivedClass.derivedMemberType1 {
  return i
}
