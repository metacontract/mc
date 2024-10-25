import type { WrapperProps } from "@docusaurus/types";
import Navbar from "@theme-original/Navbar";
import type NavbarType from "@theme/Navbar";
import React, { useEffect } from "react";

type Props = WrapperProps<typeof NavbarType>;

const addClickListeners = (elements: NodeListOf<Element>) => {
	for (const item of elements) {
		item.addEventListener("click", handleClick);
	}
};

const handleClick = (event: Event) => {
	console.log("Link clicked:", (event.target as HTMLElement).innerText);

	const target = event.target as HTMLElement;
	const liElement = target.closest("li.theme-doc-sidebar-item-category");
	if (liElement) {
		const isActive = target.classList.contains("menu__link--active");
		if (isActive) {
			liElement.classList.toggle("menu__list-item--collapsed");
		} else {
			liElement.classList.remove("menu__list-item--collapsed");
		}

		const siblingUl = liElement.querySelector("ul");
		if (siblingUl) {
			if (isActive) {
				siblingUl.style.display =
					siblingUl.style.display === "none" ? "block" : "none";
			} else {
				siblingUl.style.display = "block";
			}
		}
	}
};

const identifyBoundaryBetweenLinkAndCategory = () => {
	const listItems = document.querySelectorAll("ul.theme-doc-sidebar-menu > li");
	let lastLinkItem: Element | null = null;
	for (const item of listItems) {
		if (item.classList.contains("theme-doc-sidebar-item-link")) {
			lastLinkItem = item;
		} else if (item.classList.contains("theme-doc-sidebar-item-category")) {
			if (lastLinkItem) {
				lastLinkItem.classList.add("last-link-before-category");
				lastLinkItem = null; // Reset after adding class
			}
		}
	}
};

const observeMutations = (callback: MutationCallback) => {
	const observer = new MutationObserver(callback);
	observer.observe(document.body, {
		childList: true,
		subtree: true,
	});
	return observer;
};

export default function NavbarWrapper(props: Props): JSX.Element {
	useEffect(() => {
		// Add click listeners to all sidebar items
		const sidebarItems = document.querySelectorAll("a.menu__link--sublist");
		addClickListeners(sidebarItems);

		// Identify the boundary between link and category
		identifyBoundaryBetweenLinkAndCategory();

		// Observe mutations
		const observer = observeMutations((mutations) => {
			for (const mutation of mutations) {
				if (mutation.type === "childList") {
					const newItems = document.querySelectorAll("a.menu__link--sublist");
					addClickListeners(newItems);
				}
			}
		});

		// Cleanup function to remove event listeners
		return () => {
			for (const item of sidebarItems) {
				item.removeEventListener("click", handleClick);
			}
			observer.disconnect();
		};
	}, []);

	return <Navbar {...props} />;
}
