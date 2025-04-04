as yet unclassified
generateMooseModelOfPackageNamed: aNamedPackage
	""

	| packageEntity |
	mooseModel := FamixStModel named: 'myModelName'.
	selectedPackages := OrderedCollection new.
	selectedPackages add: aNamedPackage.
	(aNamedPackage = 'Beacon-Core' or: [
		 aNamedPackage = 'System-BasicCommandLineHandler' ])
		ifTrue: [
			self mooseModel: mooseModel.
			self packageToBeAnalyzed: OrderedCollection new ]
		ifFalse: [
			FamixStPharoImporterTask new
				importingContext: (FamixStImporterContext new
						 importImplicitVariable;
						 importAccess;
						 mergeClassAndMetaclass;
						importComment;
						 yourself);
				model: mooseModel;
				addFromPackagesNamed: selectedPackages;
				candidateClass: CandidateListOperator;
				runWithProgress.

			self mooseModel: mooseModel.

			self packageToBeAnalyzed: mooseModel allModelClasses ]