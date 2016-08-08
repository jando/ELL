////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Project:  Embedded Machine Learning Library (EMLL)
//  File:     utilities.i (interfaces)
//  Authors:  Chuck Jacobs
//
////////////////////////////////////////////////////////////////////////////////////////////////////

%include "stl.i"

%ignore utilities::operator<<;
%ignore utilities::MakeAnyIterator;
%ignore utilities::IteratorWrapper;

%{
#define SWIG_FILE_WITH_INIT
#include "AnyIterator.h"
#include "RandomEngines.h"
#include "StlIterator.h"
#include "ISerializable.h"
#include "Serialization.h"
#include "UniqueId.h"
#include "Variant.h"
#include "ObjectDescription.h"

#include "LogLoss.h"
#include "HingeLoss.h"
#include "SquaredLoss.h"
#include "LinearPredictor.h"
#include "SGDIncrementalTrainer.h"
%}

%nodefaultctor utilities::ObjectDescription;

template <typename IteratorType, typename ValueType> class StlIterator {};

%include "AnyIterator.h"
%include "RandomEngines.h"
%include "RowDataset.h"

%include "SGDIncrementalTrainer_wrap.h"

%import "ObjectDescription.h" // I'm not sure why, but this %import is necessary
%import "Serialization.h"
%include "ISerializable.h"
%include "UniqueId.h"
%include "Variant.h"
%include "ObjectDescription.h"

WRAP_OSTREAM_OUT_TO_STR(utilities::UniqueId)

// This is necessary for us to avoid leaking memory:
#ifndef SWIGXML
%template () dataset::SupervisedExample<dataset::IDataVector>;
%template () std::vector<dataset::SupervisedExample<dataset::IDataVector>>;
%template () utilities::StlIterator<typename std::vector<dataset::SupervisedExample<dataset::IDataVector>>::const_iterator, dataset::SupervisedExample<dataset::IDataVector>>;
#endif

%include "LogLoss.h"
%include "HingeLoss.h"
%include "SquaredLoss.h"

%template () trainers::SGDIncrementalTrainer<lossFunctions::LogLoss>;
%template () trainers::SGDIncrementalTrainer<lossFunctions::HingeLoss>;
%template () trainers::SGDIncrementalTrainer<lossFunctions::SquaredLoss>;

typedef predictors::LinearPredictor trainers::SGDIncrementalTrainer<lossFunctions::SquaredLoss>::Predictor;

// TODO: wrap print