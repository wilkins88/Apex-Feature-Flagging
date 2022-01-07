/**
 * @author Thomas Wilkins
 * @description Feature class for managing feature flagging within Apex. There are many ways that features can be turned on or off (triggers, apis, etc.), but this affords
 * more granular control to dictate logic flows within a specific class or method.
 */
public inherited sharing class Feature {
    @TestVisible
    private static final String CANNOT_MOCK_OUTSIDE_TEST = 'Feature flags cannot be mocked outside of a test context.';

    @TestVisible
    private static Map<String, Boolean> features {
        get {
            if (features == null) {
                features = new Map<String, Boolean>();
            }
            return features;
        } set;
    }

    /**
     * Returns whether or not the feature is activated
     * @param  featureName The name of the feature to check for
     * @return             True if the features is on, false if the feature is off or isn't configured
     */ 
    public static Boolean isOn(String featureName) {
        if (!features.containsKey(featureName)) {
            loadFeatureSetting(featureName);
        }
        return features.get(featureName);
    }

    /**
     * Allows mocking a feature only in a test context. This is useful for decoupling your code from configuration,
     * which can be problematic when ci/cd is introduced
     * @param  featureName The name of the feature to set
     * @param  isOn        Marking the feature as on or off
     */ 
    public static void setMockFeatureFlag(String featureName, Boolean isOn) {
        if (!System.Test.isRunningTest()) {
            throw new FeatureFlagException(CANNOT_MOCK_OUTSIDE_TEST);
        }
        features.put(featureName, isOn);
    }

    /**
     * Helper for loading the feature flag setting from custom metadata
     * @param  featureName the name of the feature to load
     */ 
    @TestVisible
    @SuppressWarnings('PMD.ApexCRUDViolation')
    private static void loadFeatureSetting(String featureName) {
        List<FeatureFlag__mdt> featureFlags = [
            SELECT IsOn__c
            FROM FeatureFlag__mdt
            WHERE DeveloperName = :featureName
        ];
        if (featureFlags.isEmpty()) {
            features.put(featureName, false);
        } else { 
            features.put(featureName, featureFlags[0].IsOn__c);
        }
    }
}
