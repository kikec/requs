/**
 * RQDQL.com, Requirements Definition and Query Language
 *
 * Redistribution and use in source and binary forms, with or 
 * without modification, are PROHIBITED without prior written 
 * permission from the author. This product may NOT be used 
 * anywhere and on any computer except the server platform of 
 * rqdql.com. located at www.rqdql.com. If you received this 
 * code occasionally and without intent to use it, please report 
 * this incident to the author by email: team@rqdql.com
 *
 * @author Yegor Bugayenko <egor@tpc2.com>
 * @copyright Copyright (c) rqdql.com, 2010
 * @version $Id$
 */

#ifndef __INCLUDE_SOLM_CHAIN_H
#define __INCLUDE_SOLM_CHAIN_H

#include <string>
#include <map>
#include "Solm/Term.h"

namespace solm {

/**
 * Ordered list of terms, which will happen on scope one after
 * another. Every snapshot will have a number of alternatives. Together
 * they constitute a tree-like structure.
 */
class Chain : public std::map<Term, Chain> {

public:

    /**
     * Public constructor
     */
    Chain();

    /**
     * This chain has a positive ending?
     */
    operator bool() const;

    /**
     * Get the latest Term in the chain, the latest positive. If such
     * an ending is absent, we throw an exception here. You better first
     * use operator bool() to check it.
     */
    operator Term() const;

    /**
     * We extend the list of alternatives for the chain.
     */
    Chain& operator<<(const Term&);

private:

};

}

#endif
