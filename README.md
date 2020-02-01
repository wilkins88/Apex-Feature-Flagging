# Apex Feature Flagging

Small library for managing feature flag to support Agile development models. By its nature, it does introduce some amount of tech debt with every feature (adding if/elses throughout your entire code base typically doesn't feel great). However, it is much more simple than the alternatives, such as dependency injection, so it is easier to get a team up and running with. It can also be more easily integrated with Orgs that do not have particularly well-designed implementations.

## Configuring a Feature Flag

## Implementing the Feature Switch

Adding a feature flag is fairly simple. You simply invoke Feature.isOn method and pass in the name of the feature:

```java
if (Feature.isOn('FeatureA'){
    // do feature stuff
} else {
    // do old stuff
}
```

As mentioned before, each feature like this adds tech debt, so it may be worth capturing that as a part of your process. Deeply nested feature flags can become cumbersome and difficult to read, so having tech debt tickets to go back and clean up flags that are no longer needed may be good.

## Testing a Feature

As with most items that are based on custom metadata, tests should be written as decoupled from actual records as possible. To facilitate this, the Feature.setMockFeatureFlag can be used. This method manually sets the status of the feature without requiring a custom metadata record to exist in any sort of condition, and can only be used in a Test context (will throw an error otherwise):


```java
Feature.setMockFeatureFlag('FeatureA', true);
// do test stuff
```

Testing should be done to account for situations where both the feature is off and the feature is on.
